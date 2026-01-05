<?php
header("Content-Type: application/json; charset=UTF-8");
 $servername="localhost";
 $username="root";
 $password="";
 $dbname="ep"; 
 $conn=new mysqli($servername, $username, $password, $dbname); 

$stmt = $conn->prepare("SELECT * FROM cart_items ci INNER JOIN products p ON ci.product_id=p.id_prod WHERE cart_id=?");
$stmt->bind_param("i",$_POST['id']);
$stmt->execute();
$result = $stmt->get_result();
$data = $result->fetch_all(MYSQLI_ASSOC);

echo json_encode($data);
?>