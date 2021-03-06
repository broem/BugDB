-- Creating the tables

create table Project (
  p_id          number(5) Primary key,
  project_name  varchar2(50) unique
);

--drop table Project;

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
  story_id        number(5) Primary Key,
  bug_begin_line  number default 1 not null,
  bug_end_line    number
--  bug_id          number(5) references Bug(bug_id) not null
);
-- drop table Story;
--alter table Story modify bug_begin_line number (default 1) not null;
alter table Story drop column story_id;
alter table Story add story_id number(5) primary key;

--create database Bug_Base;

create table Notes (
  story_id  number references Story(story_id) not null,
  note      varchar2(2500)
);
drop table communications;
drop table notes;
drop table commit_log;


create table Commit_Log (
  story_id    number references Story(story_id) not null,
  bug_commit  varchar2(50)
);

create table Communications (
  story_id  number references Story(story_id) not null,
  comm_log  varchar2(500)
);

--drop table Story;

create table Bug (
  bug_id        number(5) Primary key,
  found         date not null,
  resolved      date, 
  story_id      number(5) references Story(story_id) not null,
  priority      number(2) check (priority > 0 and priority <= 10),
  difficulty    number(1) check (difficulty > 0 and difficulty <= 5),
  constraint    date_check  check (found <= resolved or resolved is null)
);
-- parent bug be existing bug
drop table Bug;
alter table Bug drop column story_id;
alter table Bug add story_id number(5) references Story(story_id) not null;
--alter table Bug add priority number(2) check (priority > 0 and priority <= 10);
create table Bug_Spawn (
  parent_id   number(5) references Bug(bug_id),
  child_id    number(5) primary key references Bug(bug_id)
);

drop table Bug_Spawn;
--alter table Bug_Spawn drop column parent_id;

create table Works (
  e_id number references Employee(e_id),
  pro_id number references Project(p_id),
  hours number(4) default 0 not null,
  constraint work_pk primary key(e_id, pro_id)
);
drop table works;

create table Handles (
  bug         number(5) references Bug(bug_id),
  project_id  number(5) references Project(p_id) not null,
  constraint handle_pk primary key(bug, project_id)
);

drop table Handles;

create table Writes (
  e_id number(5) references Employee(e_id) not null,
  story_id number(5) references Story(story_id) not null,
  constraint write_pk primary key(e_id, story_id)
);
drop table writes;

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


-- drop em


