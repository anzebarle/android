<?php
header("Content-Type: application/json; charset=UTF-8");
 $servername="localhost";
 $username="root";
 $password="";
 $dbname="ep"; 
 $conn=new mysqli($servername, $username, $password, $dbname); 
var_dump($_POST);
$stmt = $conn->prepare("UPDATE  users SET first_name=?,last_name=?,email=?,password_hash=? WHERE id_users=? ");
$s=password_hash($_POST['p'],PASSWORD_DEFAULT);
$stmt->bind_param("sssss",$_POST['ime'],$_POST['priimek'],$_POST['m'],$s,$_POST['id']);
$stmt->execute();


var_dump($stmt->affected_rows);
echo json_encode($_POST['ime']);
?>