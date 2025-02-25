<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Expiry Date Tracker</title>
    <style>
        form {
            margin-bottom: 20px;
        }

        input, button {
            display: block;
            margin: 10px 0;
            padding: 8px;
        }

        #productList {
            margin-top: 20px;
        }
    </style>
</head>
<body>

    <form id="expiryForm">
        <label for="productName">Product Name:</label>
        <input type="text" id="productName" required>

        <label for="expiryDate">Expiry Date:</label>
        <input type="date" id="expiryDate" required>

        <button type="submit">Add Product</button>
    </form>

    <div id="productList"></div>

    <script>
        document.getElementById("expiryForm").addEventListener("submit", function(event) {
            event.preventDefault();

            let productName = document.getElementById("productName").value;
            let expiryDate = new Date(document.getElementById("expiryDate").value);
            let today = new Date();

            let product = { name: productName, expiry: expiryDate.toISOString() };

            // Save to local storage
            let products = JSON.parse(localStorage.getItem("products")) || [];
            products.push(product);
            localStorage.setItem("products", JSON.stringify(products));

            checkExpiryDates();
            displayProducts();
        });

        // Function to check expiry dates
        function checkExpiryDates() {
            let products = JSON.parse(localStorage.getItem("products")) || [];
            let today = new Date();

            products.forEach(product => {
                let expiry = new Date(product.expiry);
                let daysLeft = Math.ceil((expiry - today) / (1000 * 60 * 60 * 24));

                if (daysLeft <= 3 && daysLeft >= 0) {
                    alert(`⚠️ Reminder: ${product.name} will expire in ${daysLeft} days!`);
                } else if (daysLeft < 0) {
                    alert(`❌ ${product.name} has already expired!`);
                }
            });
        }

        // Function to display products
        function displayProducts() {
            let products = JSON.parse(localStorage.getItem("products")) || [];
            let list = document.getElementById("productList");
            list.innerHTML = "<h3>Tracked Products:</h3>";

            products.forEach(product => {
                list.innerHTML += `<p>${product.name} - Expiry: ${new Date(product.expiry).toDateString()}</p>`;
            });
        }

        // Run checks on page load
        document.addEventListener("DOMContentLoaded", function() {
            displayProducts();
            checkExpiryDates();
        });
    </script>

</body>
</htm