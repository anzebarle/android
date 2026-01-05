<?php
header("Content-Type: application/json; charset=UTF-8");
 $servername="localhost";
 $username="root";
 $password="";
 $dbname="ep";
 
 $conn=new mysqli($servername, $username, $password, $dbname);
 

$stmt = $conn->prepare("SELECT * FROM products WHERE id_prod=".$_GET["id"]);
$stmt->execute();

$result = $stmt->get_result();
$data = $result->fetch_all(MYSQLI_ASSOC);

echo json_encode($data);

 

?>