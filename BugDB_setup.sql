-- Creating the tables

create table Project (
  p_id          number(5) Primary key,
  project_name  varchar2(50)
);

drop table Project;

create table Employee (
  e_id          number(5) Primary key,
  first_name    varchar2(30),
  last_name     varchar2(30) not null,
  email         varchar2(30) not null unique,
  job_position  varchar2(30),
  github        varchar(30) not null unique
);

--drop table Employee;

create table Story (
  story_id        number Primary key,
  bug_begin_line  number not null,
  bug_end_line    number
  --commit_log    clob not null, these will just be new tables
  --communication clob,
  --notes           varchar2(2500)
);
drop table Story;
alter table 
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = "tabnam";

create table Notes (
  story_id  number references Story(story_id),
  note      varchar2(2500)
);


create table Commit_Log (
  story_id    number references Story(story_id),
  bug_commit  varchar2(50)
);

create table Communications (
  story_id  number references Story(story_id),
  comm_log  varchar2(500)
);

--drop table Story;

create table Bug (
  bug_id    number(5) Primary key,
  found     date not null,
  resolved  date,
  parent    number,
  story_id  number references Story(story_id),
  priority number(2) check (priority > 0 and priority <= 10),
  difficulty number(1) check (difficulty > 0 and difficulty <= 5),
  constraint date_check  check (found < resolved)
);

create table Bug_Spawn (
  parent_id   number(5) references Bug(bug_id),
  child_id    number(5) Primary key
);

create table Works (
  e_id number references Employee(e_id),
  pro_id number references Project(p_id),
  hours number(4),
  constraint work_pk primary key(e_id, pro_id)
);

create table Handles (
  bug         number(5) references Bug(bug_id),
  project_id  number(5) references Project(p_id),
  constraint handle_pk primary key(project_id)
);

create table Writes (
  e_id number(5) references Employee(e_id),
  story_id number(5) references Story(story_id)
);


-- Sequences for various Pks
create sequence project_id_seq
  start with    1000
  maxvalue      10000
  increment by  10;

create sequence employee_id_seq
  start with    1000
  maxvalue      10000
  increment by  1;  

create sequence bug_id_seq
  start with    1
  maxvalue      10000
  increment by  1;
  
create sequence story_id_seq
  start with    10
  maxvalue      10000
  increment by  10;



