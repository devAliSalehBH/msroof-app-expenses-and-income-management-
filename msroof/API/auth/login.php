<?php


include "../connect.php";

error_reporting(0);
$email =$_POST['email'];
$pass =$_POST['pass'];

$sql = "SELECT * FROM users WHERE U_Email = '$email' AND U_Password = '$pass' ";
$res = $con->query($sql);

$count = $res->num_rows;

if($count > 0){

    $sql = "SELECT * FROM users WHERE users.U_Email='$email'";
    $res = $con->query($sql);
    while($row = $res->fetch_assoc()){

        $data = $row;

    }

    echo json_encode(array("abc"=>$data));
}else {


    echo json_encode(array("abc"=>"not here"));
}