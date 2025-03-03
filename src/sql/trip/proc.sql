-- 해당 작업을 하려는 유저가 해당 그룹의 멤버인지 체크하는 프로시저
DROP PROCEDURE proc_checkValidGroupMember;

DELIMITER // -- 구분자 변경 (블럭 단위로 실행!)

CREATE PROCEDURE proc_checkValidGroupMember(IN group_id INT, IN member_id INT, IN room_id INT, OUT cnt INT) BEGIN
SELECT COUNT(tr.room_id) INTO cnt
FROM tbl_trip tr
JOIN tbl_group_member gmb ON gmb.group_id = tr.group_id
JOIN tbl_member mb ON gmb.member_id = mb.member_id
JOIN tbl_group gr ON gr.group_id = gmb.group_id
WHERE tr.group_id = group_id
  AND mb.member_id = member_id; END //
  
DELIMITER ;

-- SET @group_id = 1;
-- SET @member_id = 72;
-- 
-- SELECT *
-- FROM tbl_trip tr
-- JOIN tbl_group_member gmb ON gmb.group_id = tr.group_id
-- JOIN tbl_member mb ON gmb.member_id = mb.member_id
-- WHERE tr.group_id = @group_id
--   AND mb.member_id = @member_id;