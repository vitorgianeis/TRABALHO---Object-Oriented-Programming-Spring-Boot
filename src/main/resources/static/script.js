const API_BASE = "http://localhost:8080/api";

document.addEventListener("DOMContentLoaded", () => {
    carregarMarcas();
    carregarModelos();
    carregarVeiculos();
    carregarDashboard(); // CHAMADA DO DASHBOARD
});

function converterParaNumero(valorString) {
    if (!valorString) return null;
    return parseFloat(valorString.replace(/\./g, '').replace(',', '.'));
}

// --- DASHBOARD ---
async function carregarDashboard() {
    const res = await fetch(`${API_BASE}/veiculos/dashboard`);
    const dados = await res.json();

    document.getElementById("dash-total").innerText = dados.totalVeiculos;
    document.getElementById("dash-disponiveis").innerText = dados.disponiveis;
    
    const valorFormatado = dados.valorTotal.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
    document.getElementById("dash-valor").innerText = valorFormatado;
}

// --- CADASTRAR MARCA ---
document.getElementById("form-marca").addEventListener("submit", async (e) => {
    e.preventDefault();
    const nome = document.getElementById("marca-nome").value;
    await fetch(`${API_BASE}/marcas`, {
        method: "POST", headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ nome })
    });
    document.getElementById("marca-nome").value = "";
    carregarMarcas();
});

// --- CADASTRAR MODELO ---
document.getElementById("form-modelo").addEventListener("submit", async (e) => {
    e.preventDefault();
    const nome = document.getElementById("modelo-nome").value;
    const marcaId = document.getElementById("modelo-marca").value;
    await fetch(`${API_BASE}/modelos`, {
        method: "POST", headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ nome, marca: { id: marcaId } })
    });
    document.getElementById("modelo-nome").value = "";
    carregarModelos();
});

// --- CADASTRAR VEÍCULO ---
document.getElementById("form-veiculo").addEventListener("submit", async (e) => {
    e.preventDefault();
    const modeloId = document.getElementById("veiculo-modelo").value;
    const ano = document.getElementById("veiculo-ano").value;
    const cor = document.getElementById("veiculo-cor").value;
    const precoInput = document.getElementById("veiculo-preco").value;
    const preco = converterParaNumero(precoInput);
    const quilometragem = document.getElementById("veiculo-km").value;
    const status = document.getElementById("veiculo-status").value;
    const fotoUrl = document.getElementById("veiculo-foto").value;

    await fetch(`${API_BASE}/veiculos`, {
        method: "POST", headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ modelo: { id: modeloId }, ano, cor, preco, quilometragem, status, fotoUrl })
    });

    document.getElementById("form-veiculo").reset();
    carregarVeiculos();
    carregarDashboard(); // ATUALIZA O DASHBOARD
});

// --- CARREGAR DADOS ---
async function carregarMarcas() {
    const res = await fetch(`${API_BASE}/marcas`);
    const marcas = await res.json();
    document.getElementById("modelo-marca").innerHTML = '<option value="">Selecione a Marca...</option>';
    document.getElementById("filtro-marca").innerHTML = '<option value="">Todas as Marcas</option>';
    marcas.forEach(m => {
        document.getElementById("modelo-marca").innerHTML += `<option value="${m.id}">${m.nome}</option>`;
        document.getElementById("filtro-marca").innerHTML += `<option value="${m.id}">${m.nome}</option>`;
    });
}

async function carregarModelos() {
    const res = await fetch(`${API_BASE}/modelos`);
    const modelos = await res.json();
    document.getElementById("veiculo-modelo").innerHTML = '<option value="">Selecione o Modelo...</option>';
    modelos.forEach(m => {
        document.getElementById("veiculo-modelo").innerHTML += `<option value="${m.id}">${m.marca.nome} - ${m.nome}</option>`;
    });
    window.todosModelos = modelos; 
}

function atualizarFiltroModelo() {
    const marcaId = document.getElementById("filtro-marca").value;
    const selectModelo = document.getElementById("filtro-modelo");
    
    selectModelo.innerHTML = '<option value="">Todos os Modelos</option>';
    
    if (!marcaId) {
        window.todosModelos.forEach(m => {
            selectModelo.innerHTML += `<option value="${m.id}">${m.nome}</option>`;
        });
    } else {
        const modelosFiltrados = window.todosModelos.filter(m => m.marca.id == marcaId);
        modelosFiltrados.forEach(m => {
            selectModelo.innerHTML += `<option value="${m.id}">${m.nome}</option>`;
        });
    }
}

function limparFiltros() {
    document.getElementById("filtro-marca").value = "";
    document.getElementById("filtro-modelo").value = "";
    document.getElementById("filtro-ano").value = "";
    document.getElementById("filtro-preco").value = "";
    document.getElementById("filtro-status").value = "";
    carregarVeiculos(); 
}

async function carregarVeiculos() {
    const marcaId = document.getElementById("filtro-marca").value;
    const modeloId = document.getElementById("filtro-modelo").value;
    const ano = document.getElementById("filtro-ano").value;
    const precoMaxInput = document.getElementById("filtro-preco").value;
    const precoMax = converterParaNumero(precoMaxInput);
    const status = document.getElementById("filtro-status").value;
    
    let url = `${API_BASE}/veiculos?`;
    if (marcaId) url += `marcaId=${marcaId}&`;
    if (modeloId) url += `modeloId=${modeloId}&`;
    if (ano) url += `ano=${ano}&`;
    if (precoMax) url += `precoMax=${precoMax}&`;
    if (status) url += `status=${status}`;

    const res = await fetch(url);
    const veiculos = await res.json();
    const container = document.getElementById("lista-veiculos");
    
    document.getElementById("contador-resultados").innerText = `Foram encontrados ${veiculos.length} veículo(s).`;
    
    container.innerHTML = "";

    if (veiculos.length === 0) {
        container.innerHTML = "<p>Nenhum veículo encontrado com esses filtros.</p>";
        return;
    }

    veiculos.forEach(v => {
        const imagem = v.fotoUrl ? v.fotoUrl : "https://via.placeholder.com/300x200?text=Sem+Foto";
        const precoFormatado = v.preco.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });

        let botaoDeletar = `<button class="btn-deletar" style="background: #9ca3af; cursor: not-allowed;" onclick="alert('Altere para VENDIDO ou DESCONTINUADO antes de excluir.')">Excluir</button>`;
        if (v.status === 'VENDIDO' || v.status === 'DESCONTINUADO') {
            botaoDeletar = `<button class="btn-deletar" onclick="deletarVeiculo(${v.id})">Excluir</button>`;
        }

        container.innerHTML += `
            <div class="card-veiculo">
                <img src="${imagem}" alt="${v.modelo.nome}">
                <div class="card-info">
                    <h3>${v.modelo.marca.nome} ${v.modelo.nome}</h3>
                    <p><strong>Ano:</strong> ${v.ano} | <strong>Cor:</strong> ${v.cor}</p>
                    <p><strong>KM:</strong> ${v.quilometragem}</p>
                    <p><strong>Preço:</strong> ${precoFormatado}</p>
                    <span class="status-tag status-${v.status}">${v.status}</span>
                </div>
                <div class="card-acoes">
                    <button class="btn-editar" onclick="abrirModal(${v.id}, '${precoFormatado}', ${v.quilometragem}, '${v.status}', '${v.modelo.marca.nome} ${v.modelo.nome}')">Editar</button>
                    ${botaoDeletar} 
                </div>
            </div>
        `;
    });
}

// --- DELETAR ---
async function deletarVeiculo(id) {
    if(confirm("Tem certeza que deseja excluir este veículo?")) {
        const res = await fetch(`${API_BASE}/veiculos/${id}`, { method: "DELETE" });
        if (res.ok) {
            carregarVeiculos();
            carregarDashboard(); // ATUALIZA O DASHBOARD
        } else {
            alert("Erro ao excluir. O veículo não atende aos requisitos de exclusão.");
        }
    }
}

// --- MODAL DE EDIÇÃO (UPDATE) ---
function abrirModal(id, precoAtualFormatado, km, status, nomeVeiculo) {
    document.getElementById("edit-id").value = id;
    document.getElementById("edit-nome-veiculo").innerText = nomeVeiculo;
    const precoLimpo = precoAtualFormatado.replace("R$", "").trim(); 
    document.getElementById("edit-preco").value = precoLimpo;
    document.getElementById("edit-km").value = km;
    document.getElementById("edit-status").value = status;
    document.getElementById("modal-editar").style.display = "flex";
}

function fecharModal() {
    document.getElementById("modal-editar").style.display = "none";
}

document.getElementById("form-editar").addEventListener("submit", async (e) => {
    e.preventDefault();
    const id = document.getElementById("edit-id").value;
    const precoInput = document.getElementById("edit-preco").value;
    const preco = converterParaNumero(precoInput);
    const quilometragem = document.getElementById("edit-km").value;
    const status = document.getElementById("edit-status").value;

    await fetch(`${API_BASE}/veiculos/${id}`, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ preco, quilometragem, status })
    });

    fecharModal();
    carregarVeiculos();
    carregarDashboard(); // ATUALIZA O DASHBOARD
});