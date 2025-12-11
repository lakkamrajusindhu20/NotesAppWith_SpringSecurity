<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Signup - Notes AI</title>

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

    input[type="text"], input[type="password"] {
        width: 90%;
        padding: 10px;
        border-radius: 6px;
        border: none;
        margin-bottom: 12px;
    }

    button {
        width: 100%;
        padding: 12px;
        background: #6a11cb;
        border: none;
        color: white;
        font-weight: bold;
        border-radius: 6px;
        cursor: pointer;
        transition: 0.3s;
        margin-top: 10px;
    }

    button:hover {
        background: #4c0f9f;
    }

    .footer {
        margin-top: 20px;
        font-size: 13px;
        opacity: 0.8;
    }

    a {
        color: #fff;
        text-decoration: underline;
    }

    /* ---------------- Toast Notification ---------------- */
    #toast {
        visibility: hidden;
        min-width: 250px;
        background-color: #333;
        color: #fff;
        text-align: center;
        border-radius: 8px;
        padding: 14px;
        position: fixed;
        z-index: 1000;
        left: 50%;
        bottom: 30px;
        transform: translateX(-50%);
        font-size: 17px;
        opacity: 0;
        transition: opacity 0.5s ease, bottom 0.5s ease;
    }

    #toast.show {
        visibility: visible;
        opacity: 1;
        bottom: 50px;
    }

    .success {
        background: #2ecc71 !important;
    }
    .error {
        background: #e74c3c !important;
    }
</style>

<script>
// Show toast with custom message + color
function showToast(message, type) {
    const toast = document.getElementById("toast");
    toast.className = type; 
    toast.innerText = message;
    toast.classList.add("show");

    setTimeout(() => {
        toast.classList.remove("show");
    }, 3000);
}

async function doSignup(event) {
    event.preventDefault();

    const username = document.getElementsByName("username")[0].value;
    const password = document.getElementsByName("password")[0].value;

    const response = await fetch("/api/auth/signup", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ username, password })
    });

    if (response.status === 200) {
        showToast("Signup Successful! Redirecting…", "success");
        setTimeout(() => window.location.href = "/login", 1500);
    } else {
        showToast("Signup Failed!", "error");
    }
}
</script>

</head>
<body>

<div class="container">
    <h2>Create Account</h2>

    <form onsubmit="doSignup(event)">
        <input type="text" name="username" placeholder="Enter Username" required><br>
        <input type="password" name="password" placeholder="Enter Password" required><br>

        <button type="submit">Register</button>
    </form>

    <div class="footer">
        Already have an account? <a href="/login">Login</a>
    </div>
</div>

<!-- Toast Notification -->
<div id="toast"></div>

</body>
</html>
