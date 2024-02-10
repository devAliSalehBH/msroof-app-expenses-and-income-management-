<?php

include "../connect.php";

error_reporting(0);

$user_Id=$_POST['user_Id'];

$sql="DELETE FROM income WHERE U_Id=$user_Id";
$res=$con->query($sql);

$sql="DELETE FROM expenses WHERE U_Id=$user_Id";
$res=$con->query($sql);


if($res){
    $sql="DELETE FROM users WHERE ID=$user_Id";
    $res=$con->query($sql);
    if($res){
    echo json_encode(array("result"=>"done"));
}else{
    echo json_encode(array("result"=>"not done yyyy"));
}
}
else {
    echo json_encode(array("result"=>"not donee"));
}