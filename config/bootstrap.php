<?php
declare(strict_types=1);
if (session_status() !== PHP_SESSION_ACTIVE) { session_start(); }
require_once __DIR__ . '/config.php';
require_once __DIR__ . '/Database.php';
require_once __DIR__ . '/../classes/Employee.php';
require_once __DIR__ . '/../classes/Attendance.php';
require_once __DIR__ . '/../classes/LeaveRequest.php';
require_once __DIR__ . '/../classes/Salary.php';

function e(mixed $value): string { return htmlspecialchars((string)($value ?? ''), ENT_QUOTES, 'UTF-8'); }
function redirect(string $url): never { header('Location: ' . $url); exit; }
function csrf_token(): string {
    if (empty($_SESSION['csrf_token'])) { $_SESSION['csrf_token'] = bin2hex(random_bytes(32)); }
    return $_SESSION['csrf_token'];
}
function verify_csrf(?string $token): void {
    if (!$token || !hash_equals($_SESSION['csrf_token'] ?? '', $token)) { throw new RuntimeException('Invalid security token. Please refresh and try again.'); }
}
function post_string(string $key, string $default=''): string { return trim((string)($_POST[$key] ?? $default)); }
function valid_date(string $date): bool { $d=DateTime::createFromFormat('Y-m-d',$date); return $d && $d->format('Y-m-d')===$date; }
function money(mixed $value): float { return max(0, round((float)$value,2)); }
