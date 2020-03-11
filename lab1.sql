-- 数据库 第一次实验
-- PB17000005 赵作竑
-- 2020年3月11日
-- 注意：进行完整性检验的代码会导致执行出错！
-- 如果要查看完整结果，请不要执行该块代码！

-- 创建数据库
create database if not exists Lab1 default character set utf8mb4 collate utf8mb4_general_ci;
use Lab1;
-- 创建三个表，并添加相应的约束
create table book (
  id char(8) primary key,
  name varchar(50) not null,
  author varchar(50),
  price float unsigned,
  status enum('0', '1') default '0'
);
create table reader (
  id char(10) primary key,
  name varchar(10),
  age int unsigned,
  address varchar(20)
);
create table borrow (
  book_id char(8),
  reader_id char(10),
  borrow_date date,
  return_date date,
  primary key (book_id, reader_id, borrow_date),
  foreign key (book_id) references book(id),
  foreign key (reader_id) references reader(id)
);
-- 添加部分测试数据
-- book表
insert into book value (
    "80029089",
    "Learning MySQL",
    "Williams",
    90.83,
    '0'
  );
insert into book value (
    "70023657",
    "Head First PHP & MySQL",
    "Lynn Beighley, Michael Morrison",
    45.62,
    '1'
  );
insert into book value (
    "02306076",
    "MySQL高效编程",
    "王志刚, 江友华",
    34.55,
    '1'
  );
insert into book value (
    "01053454",
    "Computational aspects of VLSI",
    "Ullman",
    92.22,
    '0'
  );
insert into book value (
    "01011302",
    "Fundamental concepts of programming systems",
    "Ullman",
    88.43,
    '0'
  );
insert into book value (
    "01011313",
    "Principles of database systems",
    "Ullman",
    76.54,
    '1'
  );
-- reader表
insert into reader value ("PB17000001", "小明", 14, "中校区2号楼901室");
insert into reader value ("PB17000002", "小红", 15, "中校区2号楼902室");
insert into reader value ("PB17000003", "小王", 16, "中校区2号楼903室");
insert into reader value ("PB17000004", "小华", 17, "中校区2号楼904室");
insert into reader value ("PB17000005", "赵作竑", 18, "中校区2号楼920室");
insert into reader value ("PB17000006", "小芳", 19, "中校区2号楼905室");
insert into reader value ("PB17000007", "李林", 20, "中校区2号楼906室");
-- borrow表
insert into borrow value (
    "80029089",
    "PB17000001",
    "2020-01-01",
    "2020-01-04"
  );
insert into borrow value (
    "80029089",
    "PB17000001",
    "2020-01-05",
    "2020-01-10"
  );
insert into borrow value (
    "80029089",
    "PB17000002",
    "2020-01-13",
    "2020-01-19"
  );
insert into borrow value (
    "80029089",
    "PB17000003",
    "2020-01-22",
    "2020-02-03"
  );
insert into borrow value (
    "70023657",
    "PB17000001",
    "2020-01-07",
    "2020-01-23"
  );
insert into borrow value (
    "70023657",
    "PB17000007",
    "2020-02-12",
    "2020-02-13"
  );
insert into borrow value (
    "70023657",
    "PB17000001",
    "2020-02-14",
    NULL
  );
insert into borrow value (
    "02306076",
    "PB17000006",
    "2020-01-01",
    "2020-01-09"
  );
insert into borrow value (
    "02306076",
    "PB17000001",
    "2020-01-10",
    "2020-01-13"
  );
insert into borrow value (
    "02306076",
    "PB17000005",
    "2020-01-23",
    "2020-02-01"
  );
insert into borrow value (
    "02306076",
    "PB17000005",
    "2020-02-18",
    NULL
  );
insert into borrow value (
    "01053454",
    "PB17000001",
    "2020-01-03",
    "2020-01-15"
  );
insert into borrow value (
    "01053454",
    "PB17000006",
    "2020-01-16",
    "2020-02-23"
  );
insert into borrow value (
    "01053454",
    "PB17000003",
    "2020-02-25",
    "2020-02-29"
  );
insert into borrow value (
    "01011302",
    "PB17000007",
    "2020-01-01",
    "2020-01-05"
  );
insert into borrow value (
    "01011302",
    "PB17000004",
    "2020-01-06",
    "2020-01-011"
  );
insert into borrow value (
    "01011302",
    "PB17000005",
    "2020-01-12",
    "2020-01-23"
  );
insert into borrow value (
    "01011302",
    "PB17000004",
    "2020-01-25",
    "2020-02-03"
  );
insert into borrow value (
    "01011313",
    "PB17000004",
    "2020-01-02",
    "2020-01-06"
  );
insert into borrow value (
    "01011313",
    "PB17000002",
    "2020-01-22",
    "2020-01-31"
  );
insert into borrow value (
    "01011313",
    "PB17000002",
    "2020-02-01",
    NULL
  );
-- 完整性检验：
  -- 实体完整性：
insert into book value (
    "80029089",
    "Learning MySQL2",
    "Williams",
    90.83,
    '0'
  );
-- 参照完整性：
insert into borrow value (
    "00511407",
    "PB17000005",
    "2020-03-10",
    NULL
  );
-- 用户自定义完整性：
insert into book value (
    "00511407",
    "编译程序设计理论",
    "刘易斯",
    44.44,
    5
  );
-- 3.1
select
  id,
  address
from reader
where
  name = "赵作竑";
-- 3.2
select
  book.name,
  to_days(borrow.return_date) - to_days(borrow.borrow_date) as rent_days
from borrow
join reader
join book on borrow.book_id = book.id
  and borrow.reader_id = reader.id
  and reader.name = "赵作竑"
  and borrow.return_date is not null
union
select
  book.name,
  to_days(now()) - to_days(borrow.borrow_date) as rent_days
from borrow
join reader
join book on borrow.book_id = book.id
  and borrow.reader_id = reader.id
  and reader.name = "赵作竑"
  and borrow.return_date is null;
-- 3.3
select
  *
from (
    select
      distinct name
    from reader
  ) allnames
where
  allnames.name not in (
    select
      reader.name
    from borrow
    join reader on borrow.reader_id = reader.id
      and return_date is null
  );
-- 3.4
select
  name,
  price
from book
where
  author = "Ullman";
-- 3.5
select
  id,
  name
from book
join (
    select
      book_id
    from borrow
    where
      reader_id = (
        select
          id
        from reader
        where
          name = "李林"
      )
      and return_date is NULL
  ) bookids on bookids.book_id = book.id;
-- 3.6
select
  name
from reader
where
  id in (
    select
      reader_id
    from borrow
    group by
      reader_id
    HAVING
      COUNT(reader_id) > 3
  );
-- 3.7
select
  name,
  id
from reader
where
  id not in (
    select
      reader_id
    from reader
    join borrow on reader.id = borrow.reader_id
      and borrow.book_id in (
        select
          book_id
        from borrow
        where
          reader_id = (
            select
              id
            from reader
            where
              name = "李林"
          )
      )
  );
-- 3.8
select
  name,
  id
from book
where
  name like '%mysql%';
-- 3.9
  -- 创建视图
  create view 读者借书信息 as
select
  reader.id as 读者号,
  reader.name as 姓名,
  book.id as 所借图书号,
  book.name as 图书名,
  borrow.borrow_date as 开始借阅日期,
  to_days(borrow.return_date) - to_days(borrow.borrow_date) as 借期
from borrow
join reader
join book on borrow.reader_id = reader.id
  and borrow.book_id = book.id
  and borrow.return_date is not null
union
select
  reader.id as 读者号,
  reader.name as 姓名,
  book.id as 所借图书号,
  book.name as 图书名,
  borrow.borrow_date as 开始借阅日期,
  to_days(now()) - to_days(borrow.borrow_date) as 借期
from borrow
join reader
join book on borrow.reader_id = reader.id
  and borrow.book_id = book.id
  and borrow.return_date is null;
-- 利用视图查询
select
  `读者号`,
  count(`读者号`) as 借阅图书数
from `读者借书信息`
where
  to_days(now()) - to_days(`开始借阅日期`) <= 365
GROUP BY
  `读者号`;