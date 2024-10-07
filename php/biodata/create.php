<?php
header('Content-Type: application/json');
include "config/conn.php";

$nama = $_POST['nama'];
$tmplahir = $_POST['tempat_lahir'];
$tgllahir = $_POST['tanggal_lahir'];
$agama = $_POST['agama'];
$kelamin = $_POST['kelamin'];
$alamat = $_POST['alamat'];
$email = $_POST['email'];

$stmt = $db->prepare("INSERT INTO data (nama, tempat_lahir, tanggal_lahir, agama, kelamin, alamat, email) VALUES (?, ?, ?, ?, ?, ?, ?)");
$result = $stmt->execute([$nama, $tmplahir, $tgllahir, $agama, $kelamin, $alamat, $email]);

echo json_encode([
    'success' => $result
]);
