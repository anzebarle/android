<?php
header("Content-Type: application/json; charset=UTF-8");
 $servername="localhost";
 $username="root";
 $password="";
 $dbname="ep"; 
 $conn=new mysqli($servername, $username, $password, $dbname); 
 $dataArray = json_decode(file_get_contents("php://input"), true); 
 $o=0;
 $orderId=0;
 $cena=0;
 foreach($dataArray as $sectionData){ 
    if($o==0){
	 $o=$sectionData['cart_id'];	
	 $stmt = $conn->prepare("INSERT INTO orders(user_id) VALUES(?)");
     $stmt->bind_param("i",$sectionData['cart_id']);
     $stmt->execute();
	 
	 $orderId = $conn->insert_id;
	 
    
	
	}
	$cena1=$sectionData['price']*$sectionData['quantity'];
    $stmt = $conn->prepare("INSERT INTO order_items(order_id,product_id,quantity,price) VALUES(?,?,?,?)");
    $stmt->bind_param("iiid",$orderId,$sectionData['product_id'],$sectionData['quantity'],$sectionData['price']);
    $stmt->execute();
	$cena=$cena+$cena1;     
 }
    $stmt = $conn->prepare("UPDATE orders SET total_price=? where id_ord=?");
    $stmt->bind_param("di",$cena,$orderId);
    $stmt->execute();
    $stmt = $conn->prepare("DELETE FROM  cart_items WHERE cart_id= ?");
    $stmt->bind_param("i",$o);
    $stmt->execute();

var_dump($stmt->affected_rows);
echo json_encode($_POST['je']);
?>