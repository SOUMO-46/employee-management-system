<?php
declare(strict_types=1);
header('Content-Type: application/json; charset=utf-8');
if($_SERVER['REQUEST_METHOD']==='OPTIONS'){http_response_code(204);exit;}
header('Cache-Control: no-store');
require_once __DIR__.'/../config/bootstrap.php';
$db=new Database(); $conn=$db->getConnection(); $method=$_SERVER['REQUEST_METHOD']; $resource=$_GET['resource']??'employees';
if(!in_array($method,['GET','POST','PUT','DELETE','OPTIONS'],true)) out(['error'=>'Method not allowed'],405);
function out(array $data,int $status=200): never { http_response_code($status); echo json_encode($data,JSON_UNESCAPED_UNICODE|JSON_PRETTY_PRINT); exit; }
function body(): array { $raw=file_get_contents('php://input'); $data=json_decode($raw,true); if($raw!=='' && !is_array($data)) out(['error'=>'Invalid JSON body'],400); return is_array($data)?$data:$_POST; }
try {
 if($resource==='employees') { $m=new Employee($conn); if($method==='GET'){ $id=(int)($_GET['id']??0); out($id?$m->find($id):$m->all(trim((string)($_GET['q']??'')),max(1,(int)($_GET['page']??1)),max(1,min(100,(int)($_GET['limit']??20))))); } $d=body(); $id=(int)($_GET['id']??0); if($method==='POST'){out(['message'=>'Employee created','id'=>$m->create($d)],201);} if($method==='PUT'){if(!$id||!$m->find($id))out(['error'=>'Employee not found'],404);$m->update($id,$d);out(['message'=>'Employee updated']);} if($method==='DELETE'){if(!$id||!$m->find($id))out(['error'=>'Employee not found'],404);$m->delete($id);out(['message'=>'Employee deleted']);}
 } elseif($resource==='attendance') { $m=new Attendance($conn); if($method==='GET')out($m->recent(max(1,min(100,(int)($_GET['limit']??20))))); if($method==='POST'){ $d=body();$m->save((int)$d['employee_id'],(string)$d['attendance_date'],(string)$d['status'],$d['entry_time']??null,$d['exit_time']??null);out(['message'=>'Attendance saved'],201); }
 } elseif($resource==='leave') { $m=new LeaveRequest($conn); if($method==='GET')out($m->all()); if($method==='POST'){ $m->create(body());out(['message'=>'Leave request created'],201); }
 } elseif($resource==='salary') { $m=new Salary($conn); if($method==='GET')out($m->all()); if($method==='POST'){ $m->save(body());out(['message'=>'Salary saved'],201); }
 } else out(['error'=>'Unknown resource'],404);
 out(['error'=>'Method not allowed'],405);
} catch(InvalidArgumentException|RuntimeException $e){ out(['error'=>$e->getMessage()],422); } catch(mysqli_sql_exception $e){ out(['error'=>'Database request failed'],409); } catch(Throwable $e){ error_log($e->getMessage()); out(['error'=>'Internal server error'],500); }
