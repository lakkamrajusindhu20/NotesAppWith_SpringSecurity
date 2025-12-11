<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<title>Login - Notes AI</title>

<style>
    body {
        margin: 0;
        padding: 0;
        font-family: "Segoe UI", Arial, sans-serif;
        background: linear-gradient(135deg, #6a11cb, #2575fc);
        height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
    }

    .container {
        background: rgba(255, 255, 255, 0.13);
        padding: 40px;
        border-radius: 12px;
        text-align: center;
        width: 330px;
        box-shadow: 0 8px 20px rgba(0,0,0,0.2);
        backdrop-filter: blur(10px);
    }

    h2 {
        margin-bottom: 25px;
        font-size: 26px;
    }

    input {
        width: 90%;
        padding: 10px;
        margin: 10px 0;
        border: none;
        border-radius: 6px;
        outline: none;
    }

    button {
        width: 100%;
        padding: 12px;
        background: #2575fc;
        border: none;
        color: white;
        font-weight: bold;
        border-radius: 6px;
        font-size: 16px;
        margin-top: 10px;
        cursor: pointer;
        transition: 0.3s;
    }

    button:hover {
        background: #1254c4;
    }

    a {
        display: block;
        margin-top: 15px;
        color: #fff;
        text-decoration: underline;
    }

    /* ===== Toast Notification CSS ===== */
    .toast {
        position: fixed;
        top: 20px;
        right: 20px;
        padding: 15px 20px;
        border-radius: 8px;
        color: white;
        font-weight: bold;
        font-size: 15px;
        display: none;
        animation: fadeInOut 3s ease forwards;
        z-index: 9999;
    }

    .toast-success {
        background: #28a745;
    }

    .toast-error {
        background: #e53935;
    }

    @keyframes fadeInOut {
        0% { opacity: 0; transform: translateY(-10px); }
        10% { opacity: 1; transform: translateY(0); }
        90% { opacity: 1; }
        100% { opacity: 0; transform: translateY(-10px); }
    }
</style>

<script>
function showToast(message, type) {
    const toast = document.getElementById("toast");
    toast.innerText = message;
    toast.className = "toast " + (type === "success" ? "toast-success" : "toast-error");
    toast.style.display = "block";

    setTimeout(() => {
        toast.style.display = "none";
    }, 3000);
}

async function doLogin(event) {
    event.preventDefault();

    const username = document.getElementsByName("username")[0].value;
    const password = document.getElementsByName("password")[0].value;

    const response = await fetch("/api/auth/login", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ username, password })
    });

    if (response.status === 200) {
        const data = await response.json();
        localStorage.setItem("token", data.token);

        showToast("Login Successful!", "success");

        setTimeout(() => {
            window.location.href = "/notes";
        }, 1200);

    } else {
        showToast("Invalid credentials", "error");
    }
}
</script>

</head>
<body>

<div class="container">
    <h2>Login</h2>

    <form onsubmit="doLogin(event)">
        <input type="text" name="username" placeholder="Enter Username" required><br>
        <input type="password" name="password" placeholder="Enter Password" required><br>
        <button type="submit">Login</button>
    </form>

    <a href="/signup">Create New Account</a>
</div>

<!-- Toast Notification -->
<div id="toast" class="toast"></div>

</body>
</html>
