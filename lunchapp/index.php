<?php
    if(isset($_GET['page'])){
        $page = $_GET['page'];
    } else {
        $page = "app";
    }
?>
<!DOCTYPE html>

<html>
  <head>
    <title>Lunch App Template</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
    <link href="css/style.css" rel="stylesheet" media="screen">
  </head>
  <body>

      <div class="header">
          <?php include 'views/header.php' ?>
      </div>
      <div class="container main">
      <!-- @Render.Body() -->
          <?php include "views/$page.php" ?>
      </div>


      <script src="http://code.jquery.com/jquery.js"></script>
      <script src="js/bootstrap.min.js"></script>
  </body>
</html>