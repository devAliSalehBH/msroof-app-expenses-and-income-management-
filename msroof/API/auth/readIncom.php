<?php

include "../connect.php";

$user_id=$_GET['user_id'];
$tableId=$_GET['table'];
$table='';

if ($tableId=='1'){
    $table='income';
    $totalName='totalIncom';
}
elseif($tableId=='2'){
    $table='expenses';
    $totalName='totalExpen';
}

$sql="SELECT * FROM `$table` WHERE  `U_Id` = $user_id";

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