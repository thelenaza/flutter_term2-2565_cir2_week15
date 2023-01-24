<?php include_once('dbcon.php'); ?>

<?php
//For Running
$email = $_POST['email'];
$password = $_POST['password'];

//For Testing
 //$email = 'mark@gmail.com';
 //$password = '12345678';

$sql = "SELECT * FROM users WHERE email='$email' AND password = '$password' ";
$resultQuery = mysqli_query($connect, $sql);

$resultData = array();

while ($fetchData = mysqli_fetch_assoc($resultQuery)) {
    $resultData[] = $fetchData;
}

if ($resultData) {
   // print(json_encode($resultData));
    print(json_encode("Success"));
} else {
    print(json_encode("Error"));
}

?>