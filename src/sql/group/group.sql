-- 1. 그룹 목록 조회
SET @member_id = 2;


SELECT gmb.group_id
FROM tbl_group_member gmb
JOIN tbl_group gr ON gmb.group_id = gr.group_id
JOIN tbl_member mb ON mb.member_id = gmb.member_id
WHERE mb.is_deleted = 'N'
  AND mb.member_id = @member_id;

-- 2. 그룹 생성
SET @group_name = '그룹이름';


SET @member_id = 2;


INSERT INTO tbl_group(group_name, created_at)
VALUES (@group_name, DEFAULT);


INSERT INTO tbl_group_member(group_id, member_id, role_id, invite_accepted)
VALUES (LAST_INSERT_ID(), @member_id, 1, 'Y');

-- 3. 그룹 이름 수정
SET @group_id = 5;


SET @new_group_name = '새로운 그룹이름';


SET @member_id = 92;


SET @role_id = 1;


UPDATE tbl_group
SET group_name = @new_group_name
WHERE group_id = @group_id
  AND @role_id = 1
  AND
    (SELECT COUNT(*)
     FROM tbl_group_member gmb
     JOIN tbl_member mbr ON gmb.member_id = mbr.member_id
     WHERE gmb.member_id = @member_id
       AND gmb.group_id = @group_id
       AND gmb.role_id = @role_id) = 1; -- 방장이면 그룹 이름 수정 가능 (member_id 2일 때는 수정 안됨)

-- 4. 그룹 구성원 초대: TODO

-- 5. 그룹 초대 수락/거절
-- 그룹 초대 수락
SET @group_id = 3;


SET @member_id = 37;


UPDATE tbl_group_member
SET invite_accepted = 'Y'
WHERE group_id = @group_id
  AND member_id = @member_id;

-- 그룹 초대 거절
SET @group_id = 6;


SET @member_id = 67;


DELETE
FROM tbl_group_member
WHERE group_id = @group_id
  AND member_id = @member_id;
  
-- 6. 그룹장 양도
SET @current_leader_id = 87;


SET @succeeder_id = 3;


SET @group_id = 47;


UPDATE tbl_group_member
SET role_id = 2
WHERE group_id = @group_id
  AND member_id = @current_leader_id;


UPDATE tbl_group_member
SET role_id = 1
WHERE group_id = @group_id
  AND member_id = @succeeder_id;

-- 7. 그룹 삭제
SET @group_id = 47;


SET @member_id = 3;


DELETE
FROM tbl_group_member
WHERE group_id = @group_id
  AND member_id = @member_id
  AND
    (SELECT COUNT(*)
     FROM tbl_group_member gmb
     JOIN tbl_member mb ON gmb.member_id = mb.member_id
     WHERE gmb.group_id = @group_id)=1; -- 그룹의 구성원이 1명이면 그룹원 테이블에서 삭제


DELETE
FROM tbl_group
WHERE group_id = @group_id; -- 구성원이 0명이 되었으므로 그룹 삭제 가능 (RESTRICT)