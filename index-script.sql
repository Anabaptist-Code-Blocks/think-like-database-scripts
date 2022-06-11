
--use this to see how many logic reads(8k reads) the query does
set statistics io on

--use this to see cpu time and ellapsed time in milliseconds
set statistics time on

/* A */ 
select * from Users

/* B */
select Id from Users

/* C */
select * from Users where Id < 1000

/* D */
select Id from Users where LastAccessDate < '2009-01-01'
create index Users_LastAccessDate on Users(LastAccessDate)
drop index Users_LastAccessDate on Users

select DisplayName from Users where LastAccessDate < '2009-01-01'
create index Users_LastAccessDate_DisplayName on Users(LastAccessDate, DisplayName);


/* E */
select u.DisplayName, u.Location, c.Text, c.Score from Users u
	   join Comments c on c.UserId = u.Id
	   where c.Score > 5
	   order by c.Score desc

create index Comments_Score_UserId_Text on Comments(Score, UserId, Text);
create index Comments_UserId_Score_Text on Comments(UserId, Score, Text); drop index Comments_UserId_Score_Text on Comments
create index Users_DisplayName_Location on Users(DisplayName, Location) --does this help?
drop index Users_DisplayName_Location on Users 

/* F */
select u.DisplayName, u.Location, c.Text, c.Score from Users u
	   join Comments c on c.UserId = u.Id
	   where c.Score > 5 and u.Location = 'San Francisco, CA'
	   order by c.Score desc
create index Users_Location_DisplayName on Users(Location, DisplayName)

select DisplayName, Location from Users
	   order by DisplayName, Location
select Location, DisplayName from Users
	   order by Location, DisplayName

dbcc show_statistics ('Users', 'Users_Location_DisplayName')

/*G*/
select u.DisplayName, u.Location, c.Text, c.Score from Users u
	   join Comments c on c.UserId = u.Id
	   where c.Score > 5 and u.Location <> 'San Francisco, CA'
	   order by c.Score desc

/*H*/
--can I add to my existing index or do I need to make a new one?
create index Comments_CreationDate_Score_UserId_Text on Comments(UserId, CreationDate, Score) include(Text) --drop index Comments_CreationDate_Score_UserId_Text on Comments
select u.DisplayName, c.Text, c.Score from Users u
	   join Comments c on c.UserId = u.Id
	   where c.Score > 5 and u.Location = 'India'
	   and c.CreationDate between '2010-01-01' and '2011-01-01'
	   order by c.Score desc

select UserId, CreationDate, Score from Comments order by UserId, CreationDate, Score
select CreationDate, UserId, Score from Comments order by CreationDate, UserId, Score

create index Reputation_Location_DisplayName
  on dbo.Users(Reputation, Location, DisplayName);

--do i always want an index seek?
select *
	from dbo.Users
	where Reputation = 1
	  and DisplayName = 'George Washington';

--look at compile memory and compile cpu in plans
--what about parameters?
--entity framework
