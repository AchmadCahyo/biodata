<?php
header('Content-Type: application/json');
include "config/conn.php";

$stmt = $db->prepare("SELECT id, nama, tempat_lahir, tanggal_lahir, agama, kelamin, alamat, email FROM data");
$stmt->execute();
$result = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($result);