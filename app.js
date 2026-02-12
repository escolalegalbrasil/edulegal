// JavaScript source code
async function login() {

    const usuario = document.querySelector('input[name="usuario"]').value.trim();
    const pin = document.querySelector('input[name="pin"]').value.trim();

    if (pin.length < 3) {
        alert("PIN inválido");
        return;
    }

    try {

        const res = await fetch("/api/login", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                usuario,
                pin
            })
        });

        const data = await res.json();

        if (!res.ok) {
            alert(data.error || "Erro ao entrar");
            return;
        }

        // MVP → redireciona para chat
        window.location.href = "/chat";

    } catch (err) {

        alert("Erro de conexão com o servidor");

    }
}
