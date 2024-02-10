<?php

include "../connect.php";

$user_id=$_GET['user_id'];
$user_Name=$_GET['user_name'];
$user_pass=$_GET['user_pass'];

$sql="UPDATE `users` SET `U_Name` = '$user_Name' AND `U_Password` = '$user_pass' WHERE `users`.`ID` = $user_id";

$result = $con->query($sql);

$count = $result->num_rows;

if($count>0){
while($row =$result->fetch_assoc()){
    $data[]=$row;
}
echo json_encode(array("result"=>$data));
}
else {
    echo json_encode(array("result"=>"not here"));
}
?>