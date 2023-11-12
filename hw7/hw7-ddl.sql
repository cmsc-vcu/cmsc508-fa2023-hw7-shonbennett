# hw7-ddl.sql

## DO NOT RENAME OR OTHERWISE CHANGE THE SECTION TITLES OR ORDER.
## The autograder will look for specific code sections. If it can't find them, you'll get a "0"

# Code specifications.
# 0. Where there a conflict between the problem statement in the google doc and this file, this file wins.
# 1. Complete all sections below.
# 2. Table names must MATCH EXACTLY to schemas provided.
# 3. Define primary keys in each table as appropriate.
# 4. Define foreign keys connecting tables as appropriate.
# 5. Assign ID to skills, people, roles manually (you must pick the ID number!)
# 6. Assign ID in the peopleskills and peopleroles automatically (use auto_increment)
# 7. Data types: ONLY use "int", "varchar(255)", "varchar(4096)" or "date" as appropriate.

# Section 1
# Drops all tables.  This section should be amended as new tables are added.

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS peopleroles;
DROP TABLE IF EXISTS peopleskills;
DROP TABLE IF EXISTS people;
DROP TABLE IF EXISTS skills; 
DROP TABLE IF EXISTS roles;  
# ... 
SET FOREIGN_KEY_CHECKS=1;

# Section 2
# Create skills( id,name, description, tag, url, time_commitment)
# ID, name, description and tag cannot be NULL. Other fields can default to NULL.
# tag is a skill category grouping.  You can assign it based on your skill descriptions.
# time committment offers some sense of how much time was required (or will be required) to gain the skill.
# You can assign the skill descriptions.  Please be creative!

CREATE TABLE skills (
    id int not null, 
    name varchar(255) not null,
    description varchar(255) not null,
    tag varchar(255) not null, 
    url varchar(255),
    time_commitment int,
    PRIMARY KEY (id)
);

# Section 3
# Populate skills
# Populates the skills table with eight skills, their tag fields must exactly contain “Skill 1”, “Skill 2”, etc.
# You can assign skill names.  Please be creative!

INSERT INTO skills( id, name, description, tag ) values
  (1,'interpersonal skills','able to work well with the team', 'Skill 1'),
  (2,'Swift','building iOS applications', 'Skill 2');

INSERT INTO skills( id, name, description, tag, time_commitment ) values
  (3,'design','able to design user interfaces', 'Skill 3', 3),
  (4,'animation','has skills in animation industry', 'Skill 4', 5), 
  (5,'Python','can build web applications in python using Flask', 'Skill 5', 1), 
  (6,'Java','is able to write efficient code in Java', 'Skill 6', 3);

INSERT INTO skills( id, name, description, tag, url ) values
  (7,'wrestling','able to pin an opponent within 20 minutes', 'Skill 7', "www.wwe.com/past-talent"),
  (8,'professional gamer','won eSports championship', 'Skill 8', "www.esports.com/list-of-champions"); 


# Section 4
# Create people( id,first_name, last_name, email, linkedin_url, headshot_url, discord_handle, brief_bio, date_joined)
# ID cannot be null, Last name cannot be null, date joined cannot be NULL.
# All other fields can default to NULL.

CREATE TABLE people (
    id int not null, 
    last_name varchar(255) not null,
    date_joined date not null,
    first_name varchar(255),  
    email varchar(255), 
    linkedin_url varchar(255),
    headshot_url varchar(255), 
    discord_handle varchar(255), 
    brief_bio varchar(4096),
    PRIMARY KEY (id)
);

# Section 5
# Populate people with six people.
# Their last names must exactly be “Person 1”, “Person 2”, etc.
# Other fields are for you to assign.

INSERT INTO people(id,last_name, date_joined, first_name) values 
  (1,'Person 1', '2022-05-16', 'Shon'),
  (2,'Person 2', '2004-09-26', 'Beth');

INSERT INTO people(id,last_name, date_joined, first_name, discord_handle, email) values 
  (3,'Person 3', '2007-07-02', 'Naomi', 'itsnaomiraine', 'naomiraine@gmail.com'),
  (4,'Person 4', '1995-11-13', 'Johnny', 'johnnyrules', 'johnnycash@gmail.com');

INSERT INTO people(id,last_name, date_joined, first_name, headshot_url, brief_bio) values 
  (5,'Person 5', '2013-04-18', 'Victor', 'www.headshot.com/vics-photo', 'I was born and raised in VA, and now live in FL as a web developer.'),
  (6,'Person 6', '1989-06-23', 'Jack', 'www.headshot.com/jack-nicholson', 'I am Jack, better known as the Joker. I went from a life of crime to a career as a developer!');


INSERT INTO people(id,last_name, date_joined, first_name, email, linkedin_url, headshot_url, discord_handle, brief_bio) values
  (7, "Person 7", '2022-01-01', 'Bruce', "brucewayne@gothamemail.com", "www.linkedin.com/wayne-enterprises", "headshot.com/cannot-get-bruce", "imnotbatman", "I'm a billionaire, not Batman!"),
  (8, "Person 8", '2013-10-12', 'Natalya', "natthegreat@gmail.com", "www.linkedin.com/natalya-neidhart", "headshot.com/natalya", "imnattyhart", "I come from the greatest wrestling family in history, the Harts!"),
  (9, "Person 9", '2006-03-09', 'Blanca', "blancasings@outreach.com", "www.linkedin.com/blanca", "headshot.com/blanca", "blancareaches", "My name is Blanca! I was born in El Salvador!"),
  (10, "Person 10", '2015-08-23', 'David', "davidpsalmo@gmail.com", "www.linkedin.com/king-david", "headshot.com/davids-photo", "davidtheking", "I used to tend to sheep, and now I write code!");
select * from people; 
# Section 6
# Create peopleskills( id, skills_id, people_id, date_acquired )
# None of the fields can ba NULL. ID can be auto_increment.

CREATE TABLE peopleskills(
    id int not null,
    skills_id int not null, 
    people_id int not null, 
    date_acquired date default (current_date),
    PRIMARY KEY (id),
    foreign key (skills_id) references skills (id),
    foreign key (people_id) references people (id)
);

# Section 7
# Populate peopleskills such that:
# Person 1 has skills 1,3,6;
# Person 2 has skills 3,4,5;
# Person 3 has skills 1,5;
# Person 4 has no skills;
# Person 5 has skills 3,6;
# Person 6 has skills 2,3,4;
# Person 7 has skills 3,5,6;
# Person 8 has skills 1,3,5,6;
# Person 9 has skills 2,5,6;
# Person 10 has skills 1,4,5;
# Note that no one has yet acquired skills 7 and 8.
 
INSERT INTO peopleskills(id, skills_id, people_id, date_acquired) values 
  (1, 1, (SELECT id FROM people WHERE id = 1), '2002-11-07'), 
  (2, 3, (SELECT id FROM people WHERE id = 1), '2012-09-07'),
  (3, 6, (SELECT id FROM people WHERE id = 1), '2023-12-17'),
  
  (4, 3, (SELECT id FROM people WHERE id = 2), '2019-03-13'),
  (5, 4, (SELECT id FROM people WHERE id = 2), '2011-02-15'),
  (6, 5, (SELECT id FROM people WHERE id = 2), '2012-01-18'),

  (7, 1, (SELECT id FROM people WHERE id = 3), '2009-11-10'),
  (8, 5, (SELECT id FROM people WHERE id = 3), '2003-08-15'),

  (9, 3, (SELECT id FROM people WHERE id = 5), '2001-02-11'), 
  (10, 6, (SELECT id FROM people WHERE id = 5), '2011-06-30'), 

  (11, 2, (SELECT id FROM people WHERE id = 6), '2010-04-09'), 
  (12, 3, (SELECT id FROM people WHERE id = 6), '2008-08-11'),
  (13, 4, (SELECT id FROM people WHERE id = 6), '2000-01-25'),

  (14, 3, (SELECT id FROM people WHERE id = 7), '2013-09-09'), 
  (15, 5, (SELECT id FROM people WHERE id = 7), '2008-12-11'),
  (16, 6, (SELECT id FROM people WHERE id = 7), '2000-03-25'),  

  (17, 1, (SELECT id FROM people WHERE id = 8), '2008-07-09'),
  (18, 3, (SELECT id FROM people WHERE id = 8), '2022-03-04'), 
  (19, 5, (SELECT id FROM people WHERE id = 8), '2009-06-13'),
  (20, 6, (SELECT id FROM people WHERE id = 8), '2020-04-25'),   

  (21, 2, (SELECT id FROM people WHERE id = 9), '2014-05-03'), 
  (22, 5, (SELECT id FROM people WHERE id = 9), '2011-02-04'),
  (23, 6, (SELECT id FROM people WHERE id = 9), '2010-03-16'),

  (24, 1, (SELECT id FROM people WHERE id = 10), '2021-09-23'), 
  (25, 4, (SELECT id FROM people WHERE id = 10), '2002-04-11'),
  (26, 5, (SELECT id FROM people WHERE id = 10), '2007-10-22');
# Section 8
# Create roles( id, name, sort_priority )
# sort_priority is an integer and is used to provide an order for sorting roles

CREATE TABLE roles (
    id int, 
    name varchar(255),
    sort_priority int,
    PRIMARY KEY (id)
);


# Section 9
# Populate roles
# Designer, Developer, Recruit, Team Lead, Boss, Mentor
# Sort priority is assigned numerically in the order listed above (Designer=10, Developer=20, Recruit=30, etc.)

INSERT INTO roles(id, name, sort_priority) values
  (1, "Designer", 10),
  (2, "Developer", 20),
  (3, "Recruit", 30),
  (4, "Team Lead", 40),
  (5, "Boss", 50),
  (6, "Mentor", 60);

# Section 10
# Create peopleroles( id, people_id, role_id, date_assigned )
# None of the fields can be null.  ID can be auto_increment

CREATE TABLE peopleroles(
    id int not null,
    people_id int not null, 
    role_id int not null, 
    date_assigned date not null,
    PRIMARY KEY (id),
    foreign key (people_id) references people(id),
    foreign key (role_id) references roles(id)
);

# Section 11
# Populate peopleroles
# Person 1 is Developer 
# Person 2 is Boss, Mentor
# Person 3 is Developer and Team Lead
# Person 4 is Recruit
# person 5 is Recruit
# Person 6 is Developer and Designer
# Person 7 is Designer
# Person 8 is Designer and Team Lead
# Person 9 is Developer
# Person 10 is Developer and Designer

INSERT INTO peopleroles(id, people_id, role_id, date_assigned) values
  (1, 1, (SELECT id FROM roles WHERE name = "Developer"), '2014-05-03'),
  
  (2, 2, (SELECT id FROM roles WHERE name = 'Boss'), '2014-02-03'),
  (3, 2, (SELECT id FROM roles WHERE name = 'Mentor'), '2014-02-03'),
  
  (4, 3, (SELECT id FROM roles WHERE name = 'Developer'), '2011-01-11'),
  (5, 3, (SELECT id FROM roles WHERE name = 'Team Lead'), '2012-02-02'),
  
  (6, 4, (SELECT id FROM roles WHERE name = 'Recruit'), '2014-09-13'),
  
  (7, 5, (SELECT id FROM roles WHERE name = 'Recruit'), '2023-12-03'),
  
  (8, 6, (SELECT id FROM roles WHERE name = 'Developer'), '2009-12-23'),
  (9, 6, (SELECT id FROM roles WHERE name = 'Designer'), '2011-12-03'),

  (10, 7, (SELECT id FROM roles WHERE name = 'Designer'), '2013-11-09'),

  (11, 8, (SELECT id FROM roles WHERE name = 'Designer'), '2015-06-23'),
  (12, 8, (SELECT id FROM roles WHERE name = 'Team Lead'), '2022-04-09'),

  (13, 9, (SELECT id FROM roles WHERE name = 'Developer'), '2021-07-13'),

  (14, 10, (SELECT id FROM roles WHERE name = 'Developer'), '2002-02-11'),
  (15, 10, (SELECT id FROM roles WHERE name = 'Designer'), '2003-10-18');
