<?php
    define('HOST','localhost');
    define('USER','root');
    define('PASS','');
    define('DB','db_flutter');

    //$connect = mysqli_connect(HOST,USER,PASS,DB) or die('Not Connect');
    $connect=mysqli_connect('localhost','root','','db_flutter');
    mysqli_set_charset($connect,'utf8');
?>