<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Notes AI App</title>

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

        .btn {
            display: block;
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            text-decoration: none;
            color: white;
            font-weight: bold;
            border-radius: 6px;
            transition: 0.3s;
        }

        .login-btn {
            background: #2575fc;
        }

        .login-btn:hover {
            background: #1254c4;
        }

        .register-btn {
            background: #6a11cb;
        }

        .register-btn:hover {
            background: #4c0f9f;
        }

        .footer {
            margin-top: 20px;
            font-size: 13px;
            opacity: 0.8;
        }

        /* ====================== TOAST UI ====================== */
        #toast {
            visibility: hidden;
            min-width: 260px;
            background: rgba(0,0,0,0.75);
            color: #fff;
            text-align: center;
            border-radius: 8px;
            padding: 14px;
            position: fixed;
            top: 25px;
            right: 25px;
            font-size: 16px;
            z-index: 9999;
            opacity: 0;
            transition: opacity 0.6s, top 0.6s;
        }

        #toast.success {
            background: #28a745;
        }

        #toast.error {
            background: #e53935;
        }

        #toast.show {
            visibility: visible;
            opacity: 1;
            top: 50px;
        }
    </style>

</head>
<body>

<div class="container">
    <h2>Notes AI App</h2>

    <a href="/login" class="btn login-btn">Login</a>
    <a href="/signup" class="btn register-btn">Register</a>

    <div class="footer">
        Smart Notes with AI Assistance ✨
    </div>
</div>

<!-- Toast Element -->
<div id="toast"></div>

<script>
/*================== TOAST FUNCTION ==================*/
function showToast(message, type) {
    const toast = document.getElementById("toast");
    toast.className = type;  // success or error
    toast.innerText = message;
    toast.classList.add("show");

    setTimeout(() => {
        toast.classList.remove("show");
    }, 2500);
}

// Example usage (you can remove this)
// showToast("Welcome to Notes AI!", "success");
</script>

</body>
</html>
