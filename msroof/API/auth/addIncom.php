<?php

include "../connect.php";

error_reporting(0);

$price=$_POST['price'];
$name=$_POST['name'];
$u_id=$_POST['u_id'];
$table_Id=$_POST['table_id'];
$date=$_POST['date'];


$table='';
$totalName='';

if($table_Id=='1'){
    $table='income';
    $totalName='totalIncom';
}
else {
    $table='expenses';
    $totalName='totalExpen';
};

$sql="INSERT INTO `$table` (`ID`, `Price`, `Name`, `U_Id`, `Date`) VALUES (NULL, '$price', '$name', '$u_id', '$date')";
$res=$con->query($sql);

if($res){
    $sql="UPDATE users SET users.$totalName=users.$totalName+$price WHERE users.ID=$u_id";
    $res=$con->query($sql);
    if($res){
    echo json_encode(array("result"=>"done"));
    }
    else{
        echo json_encode(array("result"=>"not done"));
    }
}
else {
    echo json_encode(array("result"=>"not done $u_id"));
}
