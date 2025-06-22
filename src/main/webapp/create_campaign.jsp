<%-- 
    Document   : create_campaign
    Created on : 12 Jun 2025, 1:17:09 AM
    Author     : ameer muqrie
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Create Campaign</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #fdf6e3;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        /* Header and Navigation */
        header {
            background-color: #d6a96e;
            color: white;
            padding: 20px 0;
        }

        nav {
            display: flex;
            justify-content: center;
            gap: 40px;
        }

        nav a {
            color: white;
            text-decoration: none;
            font-weight: bold;
            font-size: 18px;
        }

        nav a:hover {
            text-decoration: underline;
        }
       
        
        .campaign-form-container {
            max-width: 800px;
            margin: 0 auto 60px;
            padding: 40px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            position: relative;
            top: 30px;
        }
        
        .campaign-form-container h2 {
            color: #4b1b00;
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.2rem;
            position: relative;
            padding-bottom: 15px;
        }
        
        .campaign-form-container h2:after {
            content: "";
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 3px;
            background: #4b1b00;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
            color: #4b1b00;
            font-size: 1.1rem;
        }
        
        .form-group input[type="text"],
        .form-group input[type="number"],
        .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #ddd;
            border-radius: 6px;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 1rem;
            transition: all 0.3s;
        }
        
        .form-group input[type="text"]:focus,
        .form-group input[type="number"]:focus,
        .form-group textarea:focus {
            border-color: #4b1b00;
            box-shadow: 0 0 0 3px rgba(75, 27, 0, 0.1);
            outline: none;
        }
        
        .form-group textarea {
            height: 150px;
            resize: vertical;
        }
        
        .file-upload {
            position: relative;
            overflow: hidden;
            display: inline-block;
            width: 100%;
        }
        
        .file-upload-btn {
            border: 2px dashed #4b1b00;
            color: #4b1b00;
            background-color: rgba(75, 27, 0, 0.05);
            padding: 30px 0;
            border-radius: 6px;
            font-size: 1rem;
            font-weight: bold;
            width: 100%;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .file-upload-btn:hover {
            background-color: rgba(75, 27, 0, 0.1);
        }
        
        .file-upload input[type="file"] {
            position: absolute;
            left: 0;
            top: 0;
            opacity: 0;
            width: 100%;
            height: 100%;
            cursor: pointer;
        }
        
        .submit-btn {
            background-color: #4b1b00;
            color: white;
            padding: 15px 25px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1.1rem;
            width: 100%;
            transition: all 0.3s;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-top: 20px;
        }
        
        .submit-btn:hover {
            background-color: #5b3a00;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(75, 27, 0, 0.3);
        }
        
        /* Preview Image */
        .image-preview {
            margin-top: 15px;
            display: none;
        }
        
        .image-preview img {
            max-width: 100%;
            max-height: 200px;
            border-radius: 6px;
            border: 2px solid #ddd;
        }
         /* Footer */
        footer {
            background-color: #d6a96e;
            color: white;
            text-align: center;
            padding: 15px 0;
        }
    </style>
    <script>
        function validateForm() {
            var title = document.forms["campaignForm"]["title"].value;
            var goal = document.forms["campaignForm"]["goal"].value;
            if (title.trim() === "") {
                alert("Title must not be empty."); 
                return false;
            }
            if (goal <= 0 || isNaN(goal)) {
                alert("Goal must be a positive number."); 
                return false;
            }
            return true;
        }

        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function(e) {
                    document.getElementById('imagePreview').style.display = 'block';
                    document.getElementById('imagePreview').innerHTML = 
                        '<img src="' + e.target.result + '" alt="Campaign Preview"/>';
                }

                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</head>
<body>
<header>
        <nav>
        <a href="admin_dashboard.jsp">Home</a>
        </nav>
    </header>
   

    <!-- Main Content -->
    <main>
        <div class="campaign-form-container">
            <h2>Create New Campaign</h2>
            <form name="campaignForm"
                  action="createCampaign"
                  method="post"
                  enctype="multipart/form-data"
                  onsubmit="return validateForm()">

                <div class="form-group">
                    <label for="title">Campaign Title</label>
                    <input type="text" id="title" name="title" placeholder="Enter your campaign title" required>
                </div>

                <div class="form-group">
                    <label for="description">Campaign Description</label>
                    <textarea id="description" name="description" 
                              placeholder="Tell people about your campaign and why it matters" required></textarea>
                </div>

                <div class="form-group">
                    <label for="goal">Fundraising Goal (RM)</label>
                    <input type="number" id="goal" name="goal" step="0.01" 
                           placeholder="Enter your target amount" required>
                </div>

                <div class="form-group">
                    <label>Campaign Image</label>
                    <div class="file-upload">
                        <div class="file-upload-btn">
                            <i class="fas fa-cloud-upload-alt" style="font-size: 24px; display: block; margin-bottom: 10px;"></i>
                            Click to upload image
                            <br>
                            <span style="font-size: 0.8rem; font-weight: normal;">(JPEG, PNG, max 5MB)</span>
                        </div>
                        <input type="file" id="photo" name="photo" accept="image/*" onchange="readURL(this);">
                    </div>
                    <div id="imagePreview" class="image-preview"></div>
                </div>

                <button type="submit" class="submit-btn">
                    <i class="fas fa-rocket" style="margin-right: 10px;"></i> Launch Campaign
                </button>
            </form>
        </div>
    </main>
<footer>
        &copy; 2025 Fundraising System. All rights reserved.
    </footer>

</body>
</html>
