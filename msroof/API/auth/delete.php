<?php

include "../connect.php";

error_reporting(0);

$tableId=$_POST['table'];
$ItemId=$_POST['Id'];
$user_Id=$_POST['user_Id'];
$Price=$_POST['price'];
$table='';
$totalName='';
if ($tableId=='1'){
    $table='income';
    $totalName='totalIncom';
}
elseif($tableId=='2'){
    $table='expenses';
    $totalName='totalExpen';
}


$sql="UPDATE users INNER JOIN $table SET users.$totalName=users.$totalName-$table.Price WHERE users.ID=$user_Id AND $table.ID=$ItemId";
$res=$con->query($sql);

if($res){
    $sql="DELETE FROM $table WHERE ID=$ItemId";
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