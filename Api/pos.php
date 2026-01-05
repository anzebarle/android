<?php
header("Content-Type: application/json; charset=UTF-8");
 $servername="localhost";
 $username="root";
 $password="";
 $dbname="ep"; 
 $conn=new mysqli($servername, $username, $password, $dbname); 
var_dump($_POST);
if($_POST['ste']==0){
	$stmt = $conn->prepare("DELETE FROM  cart_items WHERE cart_id= ? AND id_cart_items=?");
	$stmt->bind_param("ii",$_POST['ci'],$_POST['ic']);
}

else{
	$stmt = $conn->prepare("UPDATE  cart_items SET quantity=? WHERE cart_id= ? AND id_cart_items=?");
	$stmt->bind_param("iii",$_POST['ste'],$_POST['ci'],$_POST['ic']);
}


$stmt->execute();
var_dump($stmt->affected_rows);
echo json_encode($_POST['id']);
?>