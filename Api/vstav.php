<?php
header("Content-Type: application/json; charset=UTF-8");
 $servername="localhost";
 $username="root";
 $password="";
 $dbname="ep"; 
 $conn=new mysqli($servername, $username, $password, $dbname); 

$stmt = $conn->prepare("INSERT INTO cart_items(cart_id,product_id,quantity) VALUES(?,?,?)");
$stmt->bind_param("iii",$_POST['cid'],$_POST['pid'],$_POST['st']);

$stmt->execute();

$result = $stmt->get_result();
$data = $result->fetch_all(MYSQLI_ASSOC);
echo json_encode($data); 

?>