<?php
header("Content-Type: application/json; charset=UTF-8");
 $servername="localhost";
 $username="root";
 $password="";
 $dbname="ep"; 
 $conn=new mysqli($servername, $username, $password, $dbname); 
 $stmt = $conn->prepare("SELECT * FROM users");
 
 $stmt->execute();
$result = $stmt->get_result();
$data = $result->fetch_all(MYSQLI_ASSOC);
foreach($data as $l){
 if(password_get_info($l['password_hash'])['algo']==0){
 $stmt = $conn->prepare("UPDATE  users SET password_hash=? WHERE email=?");
 $s=password_hash($l['password_hash'],PASSWORD_DEFAULT);
 $stmt->bind_param("ss",$s,$l['email']);
 $stmt->execute();
 }
}
if($_POST['id']==0){
$stmt = $conn->prepare("SELECT * FROM users WHERE email=?");
$stmt->bind_param("s",$_POST['mail']);
$stmt->execute();
$result = $stmt->get_result();

if($data=$result->fetch_assoc()){
if (password_verify($_POST['pass'], $data['password_hash'])) {
  $data['password_hash']=$_POST['pass'];	
  echo json_encode([$data]); 
 }
}
}
else{
$stmt = $conn->prepare("SELECT * FROM users WHERE id_users=?");
$stmt->bind_param("i",$_POST['id']);
$stmt->execute();
$result = $stmt->get_result();

if($data=$result->fetch_assoc()){

  echo json_encode([$data]); 
 }
}

?>