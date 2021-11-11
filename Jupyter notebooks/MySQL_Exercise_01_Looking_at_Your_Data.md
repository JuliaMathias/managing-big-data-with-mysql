Copyright Jana Schaich Borg/Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)

# MySQL Exercise 1: Welcome to your first notebook!

Database interfaces vary greatly across platforms and companies.  The interface you will be using here, called Jupyter, is a web application designed for data science teams who need to create and share documents that share live code.  We will be taking advantage of Jupyter's ability to integrate instructional text with areas that allow you to write and run SQL queries.  In this course, you will practice writing queries about the Dognition data set in these Jupyter notebooks as I give you step-by-step instructions through written text.  Then once you are comfortable with the query syntax, you will practice writing queries about the Dillard's data set in Teradata Viewpoint's more traditional SQL interface, called SQL scratchpad. Your assessments each week will be based on the exercises you complete using the Dillard's dataset.

Jupyter runs in a language called Python, so some of the commands you will run in these MySQL exercises will require incorporating small amounts of Python code, along with the MySQL query itself.  Python is a very popular programming language with many statistical and visualization libraries, so you will likely encounter it in other business analysis settings.  Since many data analysis projects do not use Python, however, I will point out to you what parts of the commands are specific to Python interfaces. 

## The first thing you should do every time you start working with a database: load the SQL library

Since Jupyter is run through Python, the first thing you need to do to start practicing SQL queries is load the SQL library.  To do this, type the following line of code into the empty cell below:

```python
%load_ext sql
```



```python
%load_ext sql
```

    The sql extension is already loaded. To reload it, use:
      %reload_ext sql



The "%" in this line of code is syntax for Python, not SQL.  The "cell" I am referring to is the empty box area beside the "In [  ]:" you see on the left side of the screen.

Once you've entered the line of code, press the "run" button on the Jupyter toolbar that looks like an arrow.  It's located under “cell” in the drop-down menu bar, and next to the stop button (the solid square).  The run button is outlined in red in this picture:

![alt text](https://duke.box.com/shared/static/u9chww13kim30t5p6ndh404d9ap6auwf.jpg)

**TIP: Whenever instructions say “run” or "execute" a command in future exercises, type the appropriate code into the empty cell and execute it by pressing this same button with the arrow.**

When the library has loaded, you will see a number between the brackets that preceed the line of code you executed: 

For example, it might look like this: 

```
In [2]:
```
    

## The second thing you must do every time you want to start working with a database: connect to the database you need to use.

Now that the SQL library is loaded, we need to connect to a database.  The following command will log you into the MySQL server at localhost as the user 'studentuser' and will select the database named 'dognitiondb' :

```python
mysql://studentuser:studentpw@localhost/dognitiondb
```

However, to execute this command using SQL language instead of Python, you will need to begin the line of code with:

```python
%sql
```

Thus, the complete line of code is:

```python
%sql mysql://studentuser:studentpw@localhost/dognitiondb
```

Connect to the database by typing this command into the cell below, and running it (note: you can copy and paste the command from above rather than typing it, if you choose):




```python
%sql mysql://studentuser:studentpw@localhost/dognitiondb
```

<mark>***Every time you run a line of SQL code in Jupyter, you will need to preface the line with "%sql".  Remember to do this, even though I will not explicitly instruct you to do so for the rest of the exercises in this course.***</mark>

Once you are connected, the output cell (which reads "Out" followed by brackets) will read: "Connected:studentuser@dognitiondb".  To make this the default database for our queries, run this "USE" command:

```python
%sql USE dognitiondb
```








```python
%sql USE dognitiondb
```

     * mysql://studentuser:***@localhost/dognitiondb
    0 rows affected.





    []



You are now ready to run queries in the Dognition database!


## The third thing you should do every time you start working with a new database: get to know your data

The data sets you will be working with in business settings will be big.  REALLY big.  If you just start making queries without knowing what you are pulling out, you could hang up your servers or be staring at your computer for hours before you get an output.  Therefore, even if you are given an ER diagram or relational schema like we learned about in the first week of the course, before you start querying I strongly recommend that you (1) confirm how many tables each database has, and (2) identify the fields contained in each table of the database.  To determine how many tables each database has, use the SHOW command:

```mySQL
SHOW tables
```

**Try it yourself (TIP: if you get an error message, it's probably because you forgot to start the query with "%sql"):**


```python
%sql SHOW tables
```

     * mysql://studentuser:***@localhost/dognitiondb
    6 rows affected.





<table>
    <tr>
        <th>Tables_in_dognitiondb</th>
    </tr>
    <tr>
        <td>complete_tests</td>
    </tr>
    <tr>
        <td>dogs</td>
    </tr>
    <tr>
        <td>exam_answers</td>
    </tr>
    <tr>
        <td>reviews</td>
    </tr>
    <tr>
        <td>site_activities</td>
    </tr>
    <tr>
        <td>users</td>
    </tr>
</table>



The output that appears above should show you there are six tables in the Dognition database.  To determine what columns or fields (we will use those terms interchangeably in this course) are in each table, you can use the SHOW command again, but this time (1) you have to clarify that you want to see columns instead of tables, and (2) you have to specify from which table you want to examine the columns. 

The syntax, which sounds very similar to what you would actually say in the spoken English language, looks like this:

```mySQL
SHOW columns FROM (enter table name here)
```
or if you have multiple databases loaded:
```mySQL
SHOW columns FROM (enter table name here) FROM (enter database name here)
```
or
```mySQL
SHOW columns FROM databasename.tablename 
```
<mark> Whenever you have multiple databases loaded, you will need to specify which database a table comes from using one of the syntax options described above.</mark>

As I said in the earlier "Introduction to Query Syntax" video, it makes it easier to read and troubleshoot your queries if you always write SQL keywords in UPPERCASE format and write your table and field names in their native format.  We will only use the most important SQL keywords in this course, but a full list can be found here:

https://dev.mysql.com/doc/refman/5.7/en/keywords.html


**Question 1: How many columns does the "dogs" table have?  Enter the appropriate query below to find out:**



```python
%sql SHOW columns FROM dogs
```

     * mysql://studentuser:***@localhost/dognitiondb
    21 rows affected.





<table>
    <tr>
        <th>Field</th>
        <th>Type</th>
        <th>Null</th>
        <th>Key</th>
        <th>Default</th>
        <th>Extra</th>
    </tr>
    <tr>
        <td>gender</td>
        <td>varchar(255)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>birthday</td>
        <td>varchar(255)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>breed</td>
        <td>varchar(255)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>weight</td>
        <td>int(11)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>dog_fixed</td>
        <td>tinyint(1)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>dna_tested</td>
        <td>tinyint(1)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>created_at</td>
        <td>datetime</td>
        <td>NO</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>updated_at</td>
        <td>datetime</td>
        <td>NO</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>dimension</td>
        <td>varchar(255)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>exclude</td>
        <td>tinyint(1)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>breed_type</td>
        <td>varchar(255)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>breed_group</td>
        <td>varchar(255)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>dog_guid</td>
        <td>varchar(60)</td>
        <td>YES</td>
        <td>MUL</td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>user_guid</td>
        <td>varchar(60)</td>
        <td>YES</td>
        <td>MUL</td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>total_tests_completed</td>
        <td>varchar(255)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>mean_iti_days</td>
        <td>varchar(255)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>mean_iti_minutes</td>
        <td>varchar(255)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>median_iti_days</td>
        <td>varchar(255)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>median_iti_minutes</td>
        <td>varchar(255)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>time_diff_between_first_and_last_game_days</td>
        <td>varchar(255)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>time_diff_between_first_and_last_game_minutes</td>
        <td>varchar(255)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
</table>



You should have determined that the "dogs" table has 21 columns.  

An alternate way to learn the same information would be to use the DESCRIBE function.  The syntax is:

```mySQL
DESCRIBE tablename
```

**Question 2: Try using the DESCRIBE function to learn how many columns are in the "reviews" table:**


```python
%sql DESCRIBE reviews
```

     * mysql://studentuser:***@localhost/dognitiondb
    7 rows affected.





<table>
    <tr>
        <th>Field</th>
        <th>Type</th>
        <th>Null</th>
        <th>Key</th>
        <th>Default</th>
        <th>Extra</th>
    </tr>
    <tr>
        <td>rating</td>
        <td>int(11)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>created_at</td>
        <td>datetime</td>
        <td>NO</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>updated_at</td>
        <td>datetime</td>
        <td>NO</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>user_guid</td>
        <td>varchar(60)</td>
        <td>YES</td>
        <td>MUL</td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>dog_guid</td>
        <td>varchar(60)</td>
        <td>YES</td>
        <td>MUL</td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>subcategory_name</td>
        <td>varchar(60)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>test_name</td>
        <td>varchar(60)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
</table>



You should have determined that there are 7 columns in the "reviews" table.  

The SHOW and DESCRIBE functions give a lot more information about the table than just how many columns, or fields, there are.  Indeed, the first column of the output shows the title of each field in the table.  The column next to that describes what type of data are stored in that column.  There are 3 main types of data in MySQL: text, number, and datetime.  There are many subtypes of data within these three general categories, as described here:

https://www.hostgator.com/help/article/mysql-variable-types

The next column in the SHOW/DESCRIBE output indicates whether null values can be stored in the field in the table.  The "Key" column of the output provides the following information about each field of data in the table being described (see https://dev.mysql.com/doc/refman/5.7/en/show-columns.html for more information):

+ Empty: the column either is not indexed or is indexed only as a secondary column in a multiple-column, nonunique index.
+ PRI: the column is a PRIMARY KEY or is one of the columns in a multiple-column PRIMARY KEY.
+ UNI: the column is the first column of a UNIQUE index. 
+ MUL: the column is the first column of a nonunique index in which multiple occurrences of a given value are permitted within the column.

The "Default" field of the output indicates the default value that is assigned to the field. The "Extra" field contains any additional information that is available about a given field in that table. 

**Questions 3-6: In the cells below, examine the fields in the other 4 tables of the Dognition database:**


```python
%sql DESCRIBE complete_tests
```

     * mysql://studentuser:***@localhost/dognitiondb
    6 rows affected.





<table>
    <tr>
        <th>Field</th>
        <th>Type</th>
        <th>Null</th>
        <th>Key</th>
        <th>Default</th>
        <th>Extra</th>
    </tr>
    <tr>
        <td>created_at</td>
        <td>datetime</td>
        <td>NO</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>updated_at</td>
        <td>datetime</td>
        <td>NO</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>user_guid</td>
        <td>varchar(60)</td>
        <td>YES</td>
        <td>MUL</td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>dog_guid</td>
        <td>varchar(60)</td>
        <td>YES</td>
        <td>MUL</td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>test_name</td>
        <td>varchar(60)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>subcategory_name</td>
        <td>varchar(60)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
</table>




```python
%sql DESCRIBE exam_answers
```

     * mysql://studentuser:***@localhost/dognitiondb
    8 rows affected.





<table>
    <tr>
        <th>Field</th>
        <th>Type</th>
        <th>Null</th>
        <th>Key</th>
        <th>Default</th>
        <th>Extra</th>
    </tr>
    <tr>
        <td>script_detail_id</td>
        <td>int(11)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>subcategory_name</td>
        <td>varchar(255)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>test_name</td>
        <td>varchar(255)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>step_type</td>
        <td>varchar(255)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>start_time</td>
        <td>datetime</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>end_time</td>
        <td>datetime</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>loop_number</td>
        <td>int(11)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>dog_guid</td>
        <td>varchar(60)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
</table>




```python
%sql DESCRIBE site_activities
```

     * mysql://studentuser:***@localhost/dognitiondb
    11 rows affected.





<table>
    <tr>
        <th>Field</th>
        <th>Type</th>
        <th>Null</th>
        <th>Key</th>
        <th>Default</th>
        <th>Extra</th>
    </tr>
    <tr>
        <td>activity_type</td>
        <td>varchar(150)</td>
        <td>YES</td>
        <td>MUL</td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>description</td>
        <td>text</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>membership_id</td>
        <td>int(11)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>category_id</td>
        <td>int(11)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>script_id</td>
        <td>int(11)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>created_at</td>
        <td>datetime</td>
        <td>NO</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>updated_at</td>
        <td>datetime</td>
        <td>NO</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>user_guid</td>
        <td>varchar(255)</td>
        <td>YES</td>
        <td>MUL</td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>script_detail_id</td>
        <td>int(11)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>test_name</td>
        <td>varchar(255)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>dog_guid</td>
        <td>varchar(255)</td>
        <td>YES</td>
        <td>MUL</td>
        <td>None</td>
        <td></td>
    </tr>
</table>




```python
%sql DESCRIBE users
```

     * mysql://studentuser:***@localhost/dognitiondb
    16 rows affected.





<table>
    <tr>
        <th>Field</th>
        <th>Type</th>
        <th>Null</th>
        <th>Key</th>
        <th>Default</th>
        <th>Extra</th>
    </tr>
    <tr>
        <td>sign_in_count</td>
        <td>int(11)</td>
        <td>YES</td>
        <td></td>
        <td>0</td>
        <td></td>
    </tr>
    <tr>
        <td>created_at</td>
        <td>datetime</td>
        <td>NO</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>updated_at</td>
        <td>datetime</td>
        <td>NO</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>max_dogs</td>
        <td>int(11)</td>
        <td>YES</td>
        <td></td>
        <td>0</td>
        <td></td>
    </tr>
    <tr>
        <td>membership_id</td>
        <td>int(11)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>subscribed</td>
        <td>tinyint(1)</td>
        <td>YES</td>
        <td></td>
        <td>0</td>
        <td></td>
    </tr>
    <tr>
        <td>exclude</td>
        <td>tinyint(1)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>free_start_user</td>
        <td>tinyint(1)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>last_active_at</td>
        <td>datetime</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>membership_type</td>
        <td>int(11)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>user_guid</td>
        <td>text</td>
        <td>YES</td>
        <td>MUL</td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>city</td>
        <td>varchar(255)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>state</td>
        <td>varchar(255)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>zip</td>
        <td>varchar(255)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>country</td>
        <td>varchar(255)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
    <tr>
        <td>utc_correction</td>
        <td>varchar(255)</td>
        <td>YES</td>
        <td></td>
        <td>None</td>
        <td></td>
    </tr>
</table>



As you examine the fields in each table, you will notice that none of the Dognition tables have primary keys declared.  However, take note of which fields say "MUL" in the "Key" column of the DESCRIBE output, because these columns can still be used to link tables together.  An important thing to keep in mind, though, is that because these linking columns were not configured as primary keys, it is possible the linking fields contain NULL values or duplicate rows.
    
If you do not have a ER diagram or relational schema of the Dognition database yet, consider making one at this point, because you will need to refer back to table and column names constantly throughout designing your queries  (if you don't remember what primary keys, secondary keys, ER diagrams, or relational schemas are, review the material discussed in the first week of this course).  Some database interfaces do provide notes or visual representations about the information in each table for easy reference, but since the Jupyter interface does not provide this, take your own notes and make your own diagrams, and keep them handy.  As you will see, these diagrams and notes will save you a lot of time when you design your queries to pull data.


## Using SELECT to look at your raw data

Once you have an idea of what is in your tables look like and how they might interact, it's a good idea to look at some of the raw data itself so that you are aware of any anomalies that could pose problems for your analysis or interpretations.  To do that, we will use arguably the most important SQL statement for analysts: the SELECT statement.

SELECT is used anytime you want to retrieve data from a table.  In order to retrieve that data, you always have to provide at least two pieces of information: 
   
    (1) what you want to select, and      
    (2) from where you want to select it.  
    
I recommend that you always format your SQL code to ensure that these two pieces of information are on separate lines, so they are easy to identify quickly by eye.  

The skeleton of a SELECT statement looks like this:

```mySQL
SELECT
FROM
```

To fill in the statement, you indicate the column names you are interested in after "SELECT" and the table name (and database name, if you have multiple databases loaded) you are drawing the information from after "FROM."  So in order to look at the breeds in the dogs table, you would execute the following command:

```mySQL
SELECT breed
FROM dogs;
```

Remember:
+ SQL syntax and keywords are case insensitive.  I recommend that you always enter SQL keywords in upper case and table or column names in either lower case or their native format to make it easy to read and troubleshoot your code, but it is not a requirement to do so.  Table or column names are often case insensitive as well, but defaults may vary across database platforms so it's always a good idea to check.
+ Table or column names with spaces in them need to be surrounded by quotation marks in SQL.  MySQL accepts both double and single quotation marks, but some database systems only accept single quotation marks.  In all database systems, if a table or column name contains an SQL keyword, the name must be enclosed in backticks instead of quotation marks.
> ` 'the marks that surrounds this phrase are single quotation marks' `     
> ` "the marks that surrounds this phrase are double quotation marks" `     
> `` `the marks that surround this phrase are backticks` ``
+ The semi-colon at the end of a query is only required when you have multiple separate queries saved in the same text file or editor.  That said, I recommend that you make it a habit to always include a semi-colon at the end of your queries.  

<mark>An important note for executing queries in Jupyter: in order to tell Python that you want to execute SQL language on multiple lines, you must include two percent signs in front of the SQL prefix instead of one.</mark>  Therefore, to execute the above query, you should enter:

```mySQL
%%sql
SELECT breed
FROM dogs;
```

When Jupyter is busy executing a query, you will see an asterisk in the brackets next to the output field:

```
Out [*]
```

When the query is completed, you will see a number in the brackets next to the output field.

```
Out [5]
```

**Try it yourself:**


```python
%%sql
SELECT breed
FROM dogs;
```

     * mysql://studentuser:***@localhost/dognitiondb
    35050 rows affected.





<table>
    <tr>
        <th>breed</th>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu-Poodle Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Pembroke Welsh Corgi Mix</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Nova Scotia Duck Tolling Retriever Mix</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chesapeake Bay Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Australian Shepherd-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bouvier des Flandres</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mudi</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier-Beagle Mix</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Border Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Belgian Tervuren</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Australian Terrier</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Chihuahua- Mix</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Finnish Spitz</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Brussels Griffon</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel-Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Bedlington Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Irish Setter</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Irish Setter</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Irish Red and White Setter</td>
    </tr>
    <tr>
        <td>Poodle-Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Beagle-Schipperke Mix</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Boston Terrier-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle-Cavalier King Charles Spaniel Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Lhasa Apso-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Neapolitan Mastiff</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Collie-Shetland Sheepdog Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Golden Retriever-Collie Mix</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>American Eskimo Dog-Papillon Mix</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Belgian Tervuren Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Maltese-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Border Collie-Greyhound Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Siberian Husky-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Golden Retriever-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Poodle-Miniature Schnauzer Mix</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Silky Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Russell Terrier-Miniature Pinscher Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier-Bulldog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Kooikerhondje</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Cardigan Welsh Corgi-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Doberman Pinscher-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Canaan Dog- Mix</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Russell Terrier-Pug Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Chihuahua-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>French Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Italian Greyhound</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Leonberger</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Boykin Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Chinese Shar-Pei Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Nova Scotia Duck Tolling Retriever</td>
    </tr>
    <tr>
        <td>Nova Scotia Duck Tolling Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Lhasa Apso</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Keeshond</td>
    </tr>
    <tr>
        <td>Bull Terrier</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Shih Tzu-Maltese Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Chesapeake Bay Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Chihuahua-Miniature Pinscher Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Maltese-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Dachshund-Miniature Pinscher Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature American Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Affenpinscher</td>
    </tr>
    <tr>
        <td>Keeshond</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>English Setter</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Cane Corso Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Pointer-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Basenji Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Border Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bulldog-Beagle Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Nova Scotia Duck Tolling Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Poodle-Maltese Mix</td>
    </tr>
    <tr>
        <td>Great Dane-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Brittany-Poodle Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Scottish Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Cardigan Welsh Corgi Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bearded Collie-Tibetan Terrier Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature American Shepherd</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Icelandic Sheepdog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Pug-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier- Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Belgian Sheepdog- Mix</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Old English Sheepdog</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-American Staffordshire Terrier Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-American Staffordshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Danish-Swedish Farmdog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cardigan Welsh Corgi</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Bichon Frise-Cavalier King Charles Spaniel Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback-Boxer Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Cavalier King Charles Spaniel Mix</td>
    </tr>
    <tr>
        <td>Poodle-Cavalier King Charles Spaniel Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>Chow Chow-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Beagle Mix</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Affenpinscher</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Terrier- Mix</td>
    </tr>
    <tr>
        <td>Scottish Terrier</td>
    </tr>
    <tr>
        <td>English Setter</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Coton de Tulear</td>
    </tr>
    <tr>
        <td>Cardigan Welsh Corgi</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>American Water Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Russell Terrier-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Mastiff</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Border Collie-Belgian Tervuren Mix</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Pekingese-Dachshund Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Rottweiler- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Pug-Maltese Mix</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Siberian Husky-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Whippet</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Boston Terrier-Bulldog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Border Collie-Dalmatian Mix</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Welsh Springer Spaniel</td>
    </tr>
    <tr>
        <td>Poodle-Old English Sheepdog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Border Collie-Staffordshire Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog- Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Bichon Frise-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer-Catahoula Leopard Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Alaskan Malamute-Collie Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Coton de Tulear</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Golden Retriever-Newfoundland Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer-American Staffordshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Norfolk Terrier</td>
    </tr>
    <tr>
        <td>Norfolk Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Nova Scotia Duck Tolling Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier-Great Dane Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Wire Fox Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>French Spaniel</td>
    </tr>
    <tr>
        <td>Samoyed</td>
    </tr>
    <tr>
        <td>Coton de Tulear</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle-Maltese Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Maltese-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pekingese-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier-Miniature Schnauzer Mix</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Beagle- Mix</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Whippet</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Poodle-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Pug-Wire Fox Terrier Mix</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Pug-Wire Fox Terrier Mix</td>
    </tr>
    <tr>
        <td>Pug-Smooth Fox Terrier Mix</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Wire Fox Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Bearded Collie-Beagle Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Brussels Griffon</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Irish Setter</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Nova Scotia Duck Tolling Retriever</td>
    </tr>
    <tr>
        <td>Poodle-Dachshund Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Coton de Tulear</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Mastiff</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Polish Lowland Sheepdog</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chinese Crested-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Belgian Tervuren</td>
    </tr>
    <tr>
        <td>Belgian Tervuren</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Nova Scotia Duck Tolling Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Poodle-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Boxer-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Great Dane-Irish Wolfhound Mix</td>
    </tr>
    <tr>
        <td>Pyrenean Shepherd</td>
    </tr>
    <tr>
        <td>Pyrenean Shepherd</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Chinese Shar-Pei</td>
    </tr>
    <tr>
        <td>Mastiff</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Lhasa Apso</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Dogue de Bordeaux-Boxer Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Akita</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-Catahoula Leopard Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Scottish Terrier</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Shih Tzu-Pekingese Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Beagle-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Dachshund-Beagle Mix</td>
    </tr>
    <tr>
        <td>Silky Terrier</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Scottish Terrier</td>
    </tr>
    <tr>
        <td>-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Keeshond</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Coton de Tulear</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Chow Chow Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever- Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi-Great Pyrenees Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Pembroke Welsh Corgi Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Chesapeake Bay Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Afghan Hound-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Shorkie</td>
    </tr>
    <tr>
        <td>Field Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Chihuahua-American Staffordshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Newfoundland</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Bluetick Coonhound</td>
    </tr>
    <tr>
        <td>Pug-Miniature Pinscher Mix</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Whippet-Chinese Shar-Pei Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Boxer-Bulldog Mix</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Vizsla- Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Chow Chow-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback-Boxer Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-Whippet Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Border Collie-Pembroke Welsh Corgi Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Basenji</td>
    </tr>
    <tr>
        <td>Basenji</td>
    </tr>
    <tr>
        <td>English Setter</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Bouvier des Flandres</td>
    </tr>
    <tr>
        <td>Bouvier des Flandres</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Doberman Pinscher Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Border Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Chihuahua-Rat Terrier Mix</td>
    </tr>
    <tr>
        <td>Giant Schnauzer</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Bugg</td>
    </tr>
    <tr>
        <td>Bugg</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Maltese-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Lhasa Apso</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Poodle-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>BullBoxer</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Poodle- Mix</td>
    </tr>
    <tr>
        <td>Rat Terrier-Cavalier King Charles Spaniel Mix</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Nova Scotia Duck Tolling Retriever</td>
    </tr>
    <tr>
        <td>American Water Spaniel</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Russell Terrier-Beagle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rottweiler-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Lagotto Romagnolo</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rat Terrier-Miniature Pinscher Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Nova Scotia Duck Tolling Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Chinese Crested</td>
    </tr>
    <tr>
        <td>Irish Wolfhound</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Dandie Dinmont Terrier</td>
    </tr>
    <tr>
        <td>Standard Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Irish Setter</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>English Setter</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Siberian Husky-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Greater Swiss Mountain Dog</td>
    </tr>
    <tr>
        <td>Greater Swiss Mountain Dog</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Plott-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Poodle-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Weimaraner Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Standard Schnauzer</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>French Bulldog-Bulldog Mix</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Plott Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Boston Terrier-French Bulldog Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer-Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Labrador Retriever-American Foxhound Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Chinese Crested</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mastiff-St. Bernard Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Chow Chow-Norfolk Terrier Mix</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Newfoundland</td>
    </tr>
    <tr>
        <td>Great Pyrenees</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Poodle-Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Miniature American Shepherd</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Belgian Malinois Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Lhasa Apso</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mastiff</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Icelandic Sheepdog</td>
    </tr>
    <tr>
        <td>Icelandic Sheepdog</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Coton de Tulear</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Redbone Coonhound-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback-Weimaraner Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Coton de Tulear</td>
    </tr>
    <tr>
        <td>Chihuahua-Rat Terrier Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Poodle Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Silky Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Tibetan Spaniel</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Treeing Walker Coonhound</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>English Springer Spaniel- Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Airedale Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Spinone Italiano</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bulldog-Pug Mix</td>
    </tr>
    <tr>
        <td>Nova Scotia Duck Tolling Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Akita</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Basset Hound Mix</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Poodle-Standard Schnauzer Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Miniature Bull Terrier</td>
    </tr>
    <tr>
        <td>Chinese Shar-Pei-Pug Mix</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Airedale Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Whippet</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Appenzeller Sennenhunde</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Redbone Coonhound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese-Japanese Chin Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Basenji-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Border Collie-Greyhound Mix</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Miniature Schnauzer Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Wire Fox Terrier</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Skye Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Whippet</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Wirehaired Pointing Griffon</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Chinese Crested-Pug Mix</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Chihuahua- Mix</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Basenji</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Dutch Shepherd</td>
    </tr>
    <tr>
        <td>Norwich Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Norwich Terrier</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Maltese Mix</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer-Border Collie Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Golden Retriever-Great Pyrenees Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Collie Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Bluetick Coonhound</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Kerry Blue Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Chinook</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Shih Tzu-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Berger Picard</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Treeing Walker Coonhound</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Pointer Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Bearded Collie</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Alaskan Malamute</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-Portuguese Podengo Mix</td>
    </tr>
    <tr>
        <td>Lagotto Romagnolo</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Black Russian Terrier</td>
    </tr>
    <tr>
        <td>Black Russian Terrier</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Anatolian Shepherd Dog</td>
    </tr>
    <tr>
        <td>Tibetan Terrier</td>
    </tr>
    <tr>
        <td>Chow Chow-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Boxer-Bulldog Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Welsh Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Alaskan Malamute</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Kooikerhondje</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Norwegian Elkhound</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Treeing Walker Coonhound Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier-Boston Terrier Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>St. Bernard</td>
    </tr>
    <tr>
        <td>Boxer-Bloodhound Mix</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Brittany-German Shorthaired Pointer Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mastiff</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Nova Scotia Duck Tolling Retriever</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Chow Chow Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Nova Scotia Duck Tolling Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Nova Scotia Duck Tolling Retriever</td>
    </tr>
    <tr>
        <td>Mudi-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Pekingese</td>
    </tr>
    <tr>
        <td>Australian Shepherd- Mix</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Cardigan Welsh Corgi</td>
    </tr>
    <tr>
        <td>Eurasier</td>
    </tr>
    <tr>
        <td>Leonberger</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Leonberger</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>American Eskimo Dog-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Bullmastiff</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Collie Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Belgian Sheepdog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier- Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Bearded Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Wire Fox Terrier</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pointer-Beagle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pekingese-Parson Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>-Collie Mix</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi-American Eskimo Dog Mix</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Cardigan Welsh Corgi</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Irish Setter</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Redbone Coonhound-Vizsla Mix</td>
    </tr>
    <tr>
        <td>Spinone Italiano</td>
    </tr>
    <tr>
        <td>Spinone Italiano</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Kerry Blue Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Giant Schnauzer</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Rottweiler-Redbone Coonhound Mix</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Eurasier</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Border Collie Mix</td>
    </tr>
    <tr>
        <td>St. Bernard-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Giant Schnauzer</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Afghan Hound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Chow Chow-Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Italian Greyhound</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever- Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Nova Scotia Duck Tolling Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Scottish Terrier</td>
    </tr>
    <tr>
        <td>Tibetan Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund-Boston Terrier Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise-Cavalier King Charles Spaniel Mix</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Old English Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Standard Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>Ibizan Hound</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Chow Chow Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Shorkie</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua-Pug Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Poodle-Miniature Schnauzer Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mastiff</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Poodle Mix</td>
    </tr>
    <tr>
        <td>Belgian Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Russell Terrier-Beagle Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Bichon Frise-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Beagle-American Eskimo Dog Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-English Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Bluetick Coonhound</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Bouvier des Flandres</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Australian Labradoodle</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Cardigan Welsh Corgi</td>
    </tr>
    <tr>
        <td>Shiba Inu-Pembroke Welsh Corgi Mix</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Coton de Tulear</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pekingese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Border Collie-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Pomapoo</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Lakeland Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Papillon-Japanese Chin Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Miniature Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-American Eskimo Dog Mix</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Chihuahua-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Briard</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Irish Terrier</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Chihuahua-Miniature Pinscher Mix</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Puli</td>
    </tr>
    <tr>
        <td>Greyhound-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Puli</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Russell Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Chinese Shar-Pei Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Briard</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Lhasa Apso Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Redbone Coonhound-Bloodhound Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Russell Terrier-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Wirehaired Pointing Griffon</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Boykin Spaniel-Deutscher Wachtelhund Mix</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Akita</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Norwegian Buhund</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Italian Greyhound-Cardigan Welsh Corgi Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Dogo Argentino</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Field Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Tibetan Terrier</td>
    </tr>
    <tr>
        <td>Poodle-Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Doberman Pinscher-Black and Tan Coonhound Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Rat Terrier-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Alaskan Malamute</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Akita</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Swedish Vallhund</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Chinese Shar-Pei-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Pomapoo</td>
    </tr>
    <tr>
        <td>Miniature Pinscher-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>Pomeranian-Basenji Mix</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Portuguese Podengo Pequeno</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Boston Terrier Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Chinese Shar-Pei Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Poodle Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Standard Schnauzer</td>
    </tr>
    <tr>
        <td>Standard Schnauzer</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Border Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Border Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Cavalier King Charles Spaniel Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Silky Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Black Russian Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Berger Picard</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Newfoundland</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>BullBoxer</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Glen of Imaal Terrier</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Boxer-Ibizan Hound Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Pug-Beagle Mix</td>
    </tr>
    <tr>
        <td>Japanese Chin</td>
    </tr>
    <tr>
        <td>Japanese Chin</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Maltese Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Doberman Pinscher-Greyhound Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chesapeake Bay Retriever-Beagle Mix</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Chesapeake Bay Retriever</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Border Terrier-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Boxer-Vizsla Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Standard Schnauzer</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Redbone Coonhound-Rhodesian Ridgeback Mix</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog-Plott Mix</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Golden Retriever-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Curly-Coated Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese-Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Collie Mix</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Toy Fox Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Old English Sheepdog</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Black and Tan Coonhound</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Lhasa Apso</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Poodle Mix</td>
    </tr>
    <tr>
        <td>Cairn Terrier-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Brussels Griffon</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Tibetan Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Lagotto Romagnolo</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>American Foxhound- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Spitz</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bedlington Terrier-Whippet Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Cardigan Welsh Corgi</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Poodle-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cardigan Welsh Corgi</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Old English Sheepdog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bloodhound-Irish Setter Mix</td>
    </tr>
    <tr>
        <td>Poodle-Japanese Chin Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever- Mix</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Boxer-Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Chesapeake Bay Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Kerry Blue Terrier</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Standard Schnauzer</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Italian Greyhound-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Great Pyrenees-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Russell Terrier- Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>English Setter</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Maltese-Standard Schnauzer Mix</td>
    </tr>
    <tr>
        <td>Samoyed</td>
    </tr>
    <tr>
        <td>Samoyed</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Newfoundland</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Otterhound</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Irish Terrier</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>German Spitz</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Bull Terrier</td>
    </tr>
    <tr>
        <td>Rat Terrier-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Siberian Husky-German Shorthaired Pointer Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Old English Sheepdog</td>
    </tr>
    <tr>
        <td>Welsh Springer Spaniel</td>
    </tr>
    <tr>
        <td>Papillon-Poodle Mix</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Dachshund-Pomeranian Mix</td>
    </tr>
    <tr>
        <td>Belgian Tervuren</td>
    </tr>
    <tr>
        <td>Border Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dutch Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Boxer Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Old English Sheepdog</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>St. Bernard- Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Newfoundland</td>
    </tr>
    <tr>
        <td>Boxer-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Dachshund-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Belgian Tervuren</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Whippet</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Afghan Hound</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chow Chow-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Poodle-Miniature Schnauzer Mix</td>
    </tr>
    <tr>
        <td>Great Pyrenees</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier- Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Scottish Terrier</td>
    </tr>
    <tr>
        <td>Poodle-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Chihuahua-Shiba Inu Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Border Collie-Saluki Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Afghan Hound-Airedale Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Bugg</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Maltese Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Maltese Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Boxer-Manchester Terrier Mix</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Scottish Terrier</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shorkie</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-Akita Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Labrador Retriever- Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Welsh Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Bull Terrier-Whippet Mix</td>
    </tr>
    <tr>
        <td>Bouvier des Flandres</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Nova Scotia Duck Tolling Retriever- Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Dachshund-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Bluetick Coonhound</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Poodle- Mix</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Poodle-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Belgian Sheepdog</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Tibetan Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Keeshond-Chinese Shar-Pei Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Longhaired Pointer</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Scottish Terrier</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Poodle-Miniature Schnauzer Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Great Dane-Pointer Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Samoyed-Chow Chow Mix</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Shih Tzu-Lhasa Apso Mix</td>
    </tr>
    <tr>
        <td>Mastiff</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever- Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Miniature American Shepherd</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Bouvier des Flandres</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bouvier des Flandres</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Bouvier des Flandres</td>
    </tr>
    <tr>
        <td>Airedale Terrier</td>
    </tr>
    <tr>
        <td>Maltese-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>English Setter</td>
    </tr>
    <tr>
        <td>English Setter</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Black and Tan Coonhound Mix</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Treeing Walker Coonhound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Rat Terrier-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>English Springer Spaniel-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Chesapeake Bay Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>English Setter-Beagle Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Collie-Boxer Mix</td>
    </tr>
    <tr>
        <td>Akita- Mix</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Bedlington Terrier</td>
    </tr>
    <tr>
        <td>Bichon Frise-Poodle Mix</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu-Poodle Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Border Collie-English Springer Spaniel Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Whippet-Italian Greyhound Mix</td>
    </tr>
    <tr>
        <td>Whippet</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Chihuahua-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Schapendoes</td>
    </tr>
    <tr>
        <td>Whippet</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Boxer Mix</td>
    </tr>
    <tr>
        <td>Anatolian Shepherd Dog</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>French Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mastiff</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Nova Scotia Duck Tolling Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Lakeland Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Poodle-Pomeranian Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Beagle-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Akita-Bearded Collie Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>English Setter</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Poodle Mix</td>
    </tr>
    <tr>
        <td>Samoyed</td>
    </tr>
    <tr>
        <td>Lagotto Romagnolo</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Kai Ken</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Chesapeake Bay Retriever</td>
    </tr>
    <tr>
        <td>Airedale Terrier</td>
    </tr>
    <tr>
        <td>Irish Terrier-Gordon Setter Mix</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu-Cavalier King Charles Spaniel Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Treeing Walker Coonhound Mix</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Basenji Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Dachshund-Poodle Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Scottish Terrier Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Bouvier des Flandres</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Afghan Hound</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Border Collie Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Irish Wolfhound</td>
    </tr>
    <tr>
        <td>Italian Greyhound</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Beagle-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Dachshund-Miniature Pinscher Mix</td>
    </tr>
    <tr>
        <td>Airedale Terrier</td>
    </tr>
    <tr>
        <td>Miniature American Shepherd</td>
    </tr>
    <tr>
        <td>Boykin Spaniel</td>
    </tr>
    <tr>
        <td>Australian Shepherd-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog- Mix</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Dutch Shepherd</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Basenji</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Bullmastiff</td>
    </tr>
    <tr>
        <td>Border Collie- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dutch Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Neapolitan Mastiff</td>
    </tr>
    <tr>
        <td>Entlebucher Mountain Dog</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Spanish Water Dog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Belgian Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Lowchen</td>
    </tr>
    <tr>
        <td>Curly-Coated Retriever</td>
    </tr>
    <tr>
        <td>Irish Red and White Setter</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Alaskan Malamute Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Afghan Hound</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Smooth Fox Terrier</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Shih Tzu-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Pharaoh Hound</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Clumber Spaniel-English Springer Spaniel Mix</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Pekingese</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Greyhound Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Whippet-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Basset Hound-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Danish-Swedish Farmdog</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>St. Bernard</td>
    </tr>
    <tr>
        <td>Poodle-Maltese Mix</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Chinese Shar-Pei</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Miniature Pinscher-Rat Terrier Mix</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Newfoundland-Great Pyrenees Mix</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Tibetan Spaniel</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Airedale Terrier-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Portuguese Podengo</td>
    </tr>
    <tr>
        <td>-Manchester Terrier Mix</td>
    </tr>
    <tr>
        <td>Beagle-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Borzoi</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Tibetan Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Tibetan Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>-Bluetick Coonhound Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Irish Wolfhound</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Basenji-Manchester Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>German Pinscher</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Labrador Retriever-English Springer Spaniel Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Cardigan Welsh Corgi-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bullmastiff</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Norwich Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-St. Bernard Mix</td>
    </tr>
    <tr>
        <td>Finnish Lapphund</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu-Poodle Mix</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Czechoslovakian Vlcak</td>
    </tr>
    <tr>
        <td>Miniature Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Border Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Rottweiler-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Flat-Coated Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Beagle-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever- Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Beagle-Pointer Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Miniature Pinscher-Rat Terrier Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Dachshund-Parson Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Italian Greyhound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Border Collie-American Eskimo Dog Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>St. Bernard-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Belgian Tervuren</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Portuguese Pointer</td>
    </tr>
    <tr>
        <td>Golden Retriever-Basset Hound Mix</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Poodle Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise-Poodle Mix</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Basset Hound-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Airedale Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Maltese Mix</td>
    </tr>
    <tr>
        <td>Whippet-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever- Mix</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Collie-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Beagle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Belgian Tervuren-Whippet Mix</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Redbone Coonhound-Basset Hound Mix</td>
    </tr>
    <tr>
        <td>Dogue de Bordeaux-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Dachshund-Poodle Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Canaan Dog</td>
    </tr>
    <tr>
        <td>Boxer- Mix</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Wirehaired Pointer</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Cane Corso</td>
    </tr>
    <tr>
        <td>Newfoundland</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Chow Chow-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Akita</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Keeshond-Chow Chow Mix</td>
    </tr>
    <tr>
        <td>Weimaraner-Bluetick Coonhound Mix</td>
    </tr>
    <tr>
        <td>American Hairless Terrier</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Border Collie-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu-Lhasa Apso Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Akita-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Samoyed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Maltese-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog- Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Belgian Tervuren</td>
    </tr>
    <tr>
        <td>Pug-Lhasa Apso Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Redbone Coonhound Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Boxer Mix</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback-American Staffordshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Whippet</td>
    </tr>
    <tr>
        <td>Coton de Tulear</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Havanese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pomeranian-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever-German Shorthaired Pointer Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>English Setter</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Irish Terrier</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Whippet-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Belgian Tervuren</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Bouvier des Flandres</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Border Collie Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier- Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Springer Spaniel-Pointer Mix</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer-Greyhound Mix</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Golden Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog- Mix</td>
    </tr>
    <tr>
        <td>Beagle-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Labrador Retriever-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Icelandic Sheepdog</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Welsh Terrier</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature American Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Poodle-Miniature Schnauzer Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Australian Labradoodle</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pekingese</td>
    </tr>
    <tr>
        <td>Poodle-Rat Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Pinscher- Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise-Poodle Mix</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Affenpinscher</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Doberman Pinscher-Pug Mix</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Finnish Lapphund</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Poodle-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Boxer Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mastiff</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Chihuahua-Rat Terrier Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Irish Wolfhound</td>
    </tr>
    <tr>
        <td>Maltese-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Italian Greyhound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Foxhound</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Shih Tzu-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier</td>
    </tr>
    <tr>
        <td>Bugg</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Greyhound Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Bulldog-Chesapeake Bay Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Maltese-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Maltese-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Keeshond</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Miniature American Shepherd</td>
    </tr>
    <tr>
        <td>Australian Shepherd- Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Australian Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Australian Shepherd- Mix</td>
    </tr>
    <tr>
        <td>Dachshund-Doberman Pinscher Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Norwich Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Leonberger</td>
    </tr>
    <tr>
        <td>Chihuahua-Rat Terrier Mix</td>
    </tr>
    <tr>
        <td>Finnish Spitz</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Scottish Deerhound</td>
    </tr>
    <tr>
        <td>Saluki</td>
    </tr>
    <tr>
        <td>Saluki</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>-Toy Fox Terrier Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Poodle Mix</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Scottish Terrier</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Coton de Tulear</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cardigan Welsh Corgi</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Collie-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Spitz</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer- Mix</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Weimaraner Mix</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Mastiff Mix</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Bouvier des Flandres</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-Pembroke Welsh Corgi Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Havanese-Pekingese Mix</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mastiff</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund-Pug Mix</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Grand Basset Griffon Vendeen</td>
    </tr>
    <tr>
        <td>Old English Sheepdog-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Border Collie Mix</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-Bullmastiff Mix</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chinese Shar-Pei</td>
    </tr>
    <tr>
        <td>Brussels Griffon</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Brussels Griffon</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>English Springer Spaniel-Border Collie Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Redbone Coonhound</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Schipperke</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Shih Tzu-Maltese Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Maltese-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Coton de Tulear</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Jindo-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund-Flat-Coated Retriever Mix</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Boxer-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Bugg</td>
    </tr>
    <tr>
        <td>Akita</td>
    </tr>
    <tr>
        <td>Golden Retriever-Chow Chow Mix</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Airedale Terrier</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Border Collie-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Scottish Terrier</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Lhasa Apso</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dalmatian-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Poodle- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mudi</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Collie- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>-Beagle Mix</td>
    </tr>
    <tr>
        <td>Basenji- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Mastiff Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Newfoundland</td>
    </tr>
    <tr>
        <td>Chihuahua-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Russell Terrier-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Anatolian Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever- Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Chinese Shar-Pei</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>-Boxer Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Boxer-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Coton de Tulear</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Hovawart</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-American Staffordshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Basset Hound- Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Hovawart</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Afghan Hound-Affenpinscher Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>-Poodle Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Labrador Retriever- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback-Redbone Coonhound Mix</td>
    </tr>
    <tr>
        <td>German Wirehaired Pointer</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog- Mix</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Dachshund-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Boxer-Redbone Coonhound Mix</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Dachshund-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund-Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Weimaraner Mix</td>
    </tr>
    <tr>
        <td>Poodle-German Spitz Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Border Collie Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>West Highland White Terrier-Border Terrier Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Border Collie- Mix</td>
    </tr>
    <tr>
        <td>Lhasa Apso-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Bulldog-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Akita</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-German Shorthaired Pointer Mix</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Maltese-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Golden Retriever-Great Pyrenees Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cane Corso</td>
    </tr>
    <tr>
        <td>Labrador Retriever- Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Bulldog Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Akita Mix</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier- Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Terrier-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Border Collie Mix</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Siberian Husky-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Akita</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Coton de Tulear</td>
    </tr>
    <tr>
        <td>Mastiff-Bulldog Mix</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Border Collie- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bullmastiff</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Weimaraner Mix</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Rottweiler-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Coton de Tulear</td>
    </tr>
    <tr>
        <td>Pekingese</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Pug-French Bulldog Mix</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback-Catahoula Leopard Dog Mix</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cardigan Welsh Corgi</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Poodle-Miniature Schnauzer Mix</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>St. Bernard</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>German Shepherd Dog- Mix</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Wire Fox Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Redbone Coonhound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Treeing Walker Coonhound-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Whippet</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Miniature American Shepherd</td>
    </tr>
    <tr>
        <td>Basenji</td>
    </tr>
    <tr>
        <td>Newfoundland-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Hovawart</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Weimaraner- Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Irish Setter</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chow Chow-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Chinese Crested</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Alaskan Malamute-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Doberman Pinscher Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Siberian Husky- Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Miniature American Shepherd</td>
    </tr>
    <tr>
        <td>Cane Corso</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Nova Scotia Duck Tolling Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Bearded Collie</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Treeing Walker Coonhound- Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Great Dane Mix</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Lhasa Apso</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Whippet</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Anatolian Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Bull Terrier-Staffordshire Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Scottish Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Silky Terrier-Basset Hound Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Samoyed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Chihuahua-Miniature Pinscher Mix</td>
    </tr>
    <tr>
        <td>Chihuahua-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Airedale Terrier</td>
    </tr>
    <tr>
        <td>Cardigan Welsh Corgi</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Pug-Beagle Mix</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chesapeake Bay Retriever-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Anatolian Shepherd Dog</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Lhasa Apso</td>
    </tr>
    <tr>
        <td>Australian Shepherd- Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu-Poodle Mix</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Russian Toy</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Basset Hound-Beagle Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>German Shepherd Dog- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Great Pyrenees</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Italian Greyhound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Boxer-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mastiff</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Weimaraner Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Beagle Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Boston Terrier-Pug Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Poodle-Tibetan Terrier Mix</td>
    </tr>
    <tr>
        <td>Brussels Griffon</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Whippet-Tibetan Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Airedale Terrier</td>
    </tr>
    <tr>
        <td>Scottish Terrier</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Treeing Walker Coonhound</td>
    </tr>
    <tr>
        <td>Golden Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mastiff</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Border Collie-English Springer Spaniel Mix</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Boxer Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Perro de Presa Canario</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Golden Retriever- Mix</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Siberian Husky-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Irish Water Spaniel</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Chinese Shar-Pei</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Nova Scotia Duck Tolling Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>Belgian Tervuren</td>
    </tr>
    <tr>
        <td>West Highland White Terrier-Parson Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Schipperke</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>-Anatolian Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Pumi</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Clumber Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Setter</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Papillon Mix</td>
    </tr>
    <tr>
        <td>Old English Sheepdog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mastiff</td>
    </tr>
    <tr>
        <td>Saluki</td>
    </tr>
    <tr>
        <td>Chihuahua- Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Welsh Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Newfoundland</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Whippet</td>
    </tr>
    <tr>
        <td>Bearded Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Shih Tzu-Maltese Mix</td>
    </tr>
    <tr>
        <td>Bouvier des Flandres</td>
    </tr>
    <tr>
        <td>Standard Schnauzer</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Silky Terrier</td>
    </tr>
    <tr>
        <td>-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Poodle Mix</td>
    </tr>
    <tr>
        <td>Maltese-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Maltese-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Dogue de Bordeaux</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Norwich Terrier</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Chinese Crested</td>
    </tr>
    <tr>
        <td>Labrador Retriever-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Airedale Terrier-Border Collie Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Jack-A-Poo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Pointer</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Mastiff-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Airedale Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Poodle-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Poodle-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Bouvier des Flandres</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Bullmastiff</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Wirehaired Vizsla</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Italian Greyhound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Setter</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mastiff</td>
    </tr>
    <tr>
        <td>St. Bernard</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Chinese Crested</td>
    </tr>
    <tr>
        <td>Labrador Retriever- Mix</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Border Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Pekingese</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Pug-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Chow Chow</td>
    </tr>
    <tr>
        <td>Chihuahua-Pomeranian Mix</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Greyhound-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Border Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Dachshund-Wire Fox Terrier Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Boxer Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua-Cardigan Welsh Corgi Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Bugg</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Rat Terrier-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>Bulldog-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Bull Terrier</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Akita-Belgian Tervuren Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Bulldog-Boston Terrier Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Shih Tzu-Pomeranian Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog- Mix</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle-American Foxhound Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Tibetan Spaniel</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Doberman Pinscher-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Beagle-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Manchester Terrier</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Pug-Chinese Shar-Pei Mix</td>
    </tr>
    <tr>
        <td>Miniature Pinscher-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Rat Terrier- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Japanese Chin</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>-Pomeranian Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua-Smooth Fox Terrier Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Chihuahua-Miniature Schnauzer Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Italian Greyhound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Standard Schnauzer Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Boston Terrier-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Basenji</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Japanese Chin-Italian Greyhound Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier- Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu-Poodle Mix</td>
    </tr>
    <tr>
        <td>Chinese Crested</td>
    </tr>
    <tr>
        <td>Beagle-Pug Mix</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Basset Hound-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Weimaraner Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Scottish Terrier-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Alaskan Malamute</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Wirehaired Pointing Griffon</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Newfoundland</td>
    </tr>
    <tr>
        <td>St. Bernard</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Boxer Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Nova Scotia Duck Tolling Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-Irish Setter Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Bulldog-French Bulldog Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>-Chesapeake Bay Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier- Mix</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>-Poodle Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Old English Sheepdog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Finnish Spitz</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Tibetan Terrier</td>
    </tr>
    <tr>
        <td>Affenpinscher-Airedale Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Chihuahua-Italian Greyhound Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>-Border Collie Mix</td>
    </tr>
    <tr>
        <td>American Eskimo Dog-Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>Maltese-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Bichon Frise-Poodle Mix</td>
    </tr>
    <tr>
        <td>Maltese-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Miniature Bull Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Chinese Crested-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>American Foxhound-Pointer Mix</td>
    </tr>
    <tr>
        <td>Chinese Crested</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Poodle-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Chinese Shar-Pei-Staffordshire Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Beauceron</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Border Collie-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>English Springer Spaniel-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Silky Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever-Great Pyrenees Mix</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>St. Bernard-Brittany Mix</td>
    </tr>
    <tr>
        <td>Akita</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Chesapeake Bay Retriever Mix</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Scottish Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Bugg</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Boxer-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Border Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Alaskan Malamute-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>-Whippet Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Russell Terrier-Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise-Poodle Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Wire Fox Terrier</td>
    </tr>
    <tr>
        <td>Standard Schnauzer</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier- Mix</td>
    </tr>
    <tr>
        <td>Chow Chow-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Maltese-Pomeranian Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Russell Terrier-Basenji Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise-American Eskimo Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog-Border Collie Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Border Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Standard Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Dachshund- Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Chow Chow Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Pointer Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Chow Chow</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Bichon Frise-Maltese Mix</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rottweiler-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chow Chow</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Pomeranian-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Wirehaired Vizsla</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Golden Retriever-Great Pyrenees Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Mastiff Mix</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog</td>
    </tr>
    <tr>
        <td>Siberian Husky-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Pekingese Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chow Chow-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Cane Corso</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua-Rat Terrier Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Perro de Presa Canario-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Whippet-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Maltese- Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Dalmatian-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Boston Terrier-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Lhasa Apso- Mix</td>
    </tr>
    <tr>
        <td>Brittany-Pekingese Mix</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>English Setter</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Beagle-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Poodle-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Chihuahua-Parson Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Chihuahua-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Pinscher- Mix</td>
    </tr>
    <tr>
        <td>Dogue de Bordeaux</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bullmastiff</td>
    </tr>
    <tr>
        <td>Mastiff</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Alaskan Malamute</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Chow Chow</td>
    </tr>
    <tr>
        <td>Basset Hound-Beagle Mix</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Dalmatian-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle-Maltese Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Lhasa Apso</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>BullBoxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Basenji-Cardigan Welsh Corgi Mix</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Chesapeake Bay Retriever</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Chow Chow</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Irish Setter</td>
    </tr>
    <tr>
        <td>Beagle-Pug Mix</td>
    </tr>
    <tr>
        <td>Bull Terrier</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Bearded Collie</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Great Dane Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Chow Chow</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pekingese</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Bearded Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>-Staffordshire Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Chow Chow-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Bulldog Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise-Poodle Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Norwich Terrier</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Poodle Mix</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Maltese Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Lagotto Romagnolo-Schapendoes Mix</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Golden Retriever-Great Pyrenees Mix</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Silky Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer- Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle- Mix</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Bolognese Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Pointer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Great Pyrenees</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Chihuahua-Papillon Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Scottish Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Basset Hound-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>St. Bernard</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Bull Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise-Cavalier King Charles Spaniel Mix</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Whippet</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Bullmastiff</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Australian Shepherd-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Pekingese-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>English Springer Spaniel-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Beagle-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Brussels Griffon</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Nova Scotia Duck Tolling Retriever</td>
    </tr>
    <tr>
        <td>Bouvier des Flandres</td>
    </tr>
    <tr>
        <td>Shih Tzu-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Whippet</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Staffordshire Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Havanese-Maltese Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Greyhound Mix</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shorkie</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Silky Terrier</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Scottish Terrier</td>
    </tr>
    <tr>
        <td>Chihuahua-Italian Greyhound Mix</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua-Dachshund Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Weimaraner Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Maltese Mix</td>
    </tr>
    <tr>
        <td>Maltese-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Old English Sheepdog</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Cairn Terrier-Lhasa Apso Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Boxer-Dutch Shepherd Mix</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Toy Fox Terrier</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Alaskan Malamute</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Boxer Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Boston Terrier Mix</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Alaskan Malamute</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Chihuahua-Pembroke Welsh Corgi Mix</td>
    </tr>
    <tr>
        <td>Italian Greyhound</td>
    </tr>
    <tr>
        <td>Cane Corso</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Chow Chow Mix</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Poodle-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Great Pyrenees</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cane Corso</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Black and Tan Coonhound- Mix</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Boston Terrier-Beagle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cairn Terrier-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Chihuahua-Rat Terrier Mix</td>
    </tr>
    <tr>
        <td>-Pug Mix</td>
    </tr>
    <tr>
        <td>Shorkie</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>St. Bernard</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Chow Chow</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Chow Chow</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua-Italian Greyhound Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Basenji</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Scottish Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Shih Tzu-Wire Fox Terrier Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Pug-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Ibizan Hound Mix</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Airedale Terrier-Afghan Hound Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese-Pekingese Mix</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>BullBoxer</td>
    </tr>
    <tr>
        <td>Newfoundland</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Keeshond-Weimaraner Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua- Mix</td>
    </tr>
    <tr>
        <td>Gordon Setter</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Beagle-American English Coonhound Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua-Rat Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Dogue de Bordeaux</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Lhasa Apso-Pekingese Mix</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Rat Terrier-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Chow Chow</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Golden Retriever-Chow Chow Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Cardigan Welsh Corgi</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Poodle-Japanese Chin Mix</td>
    </tr>
    <tr>
        <td>Lhasa Apso</td>
    </tr>
    <tr>
        <td>Border Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Alaskan Malamute- Mix</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Poodle-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Scottish Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shorkie</td>
    </tr>
    <tr>
        <td>Bichon Frise-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Newfoundland</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Belgian Malinois-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Chow Chow Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Akita-Affenpinscher Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Rottweiler-Rhodesian Ridgeback Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese-Pomeranian Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Cane Corso</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pekingese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Redbone Coonhound</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Silky Terrier</td>
    </tr>
    <tr>
        <td>Great Dane-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Chow Chow-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Chihuahua-Japanese Chin Mix</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Irish Terrier Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Australian Shepherd- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>-Pomeranian Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Coton de Tulear</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Border Collie- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua-Pomeranian Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>-Cairn Terrier Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog-Great Pyrenees Mix</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>French Bulldog-Boston Terrier Mix</td>
    </tr>
    <tr>
        <td>Pekingese-Parson Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi-Basset Hound Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Icelandic Sheepdog-Keeshond Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>English Foxhound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Rat Terrier-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Spitz</td>
    </tr>
    <tr>
        <td>Poodle-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Boxer-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Beagle-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Boston Terrier-Doberman Pinscher Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Italian Greyhound</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bloodhound</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Coton de Tulear</td>
    </tr>
    <tr>
        <td>Spinone Italiano</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Border Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Pomeranian-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Coton de Tulear</td>
    </tr>
    <tr>
        <td>Chihuahua-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier- Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Rottweiler-Mastiff Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Great Pyrenees Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Affenpinscher</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-Bulldog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Dachshund-Beagle Mix</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Pomeranian-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>-Boxer Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Bloodhound</td>
    </tr>
    <tr>
        <td>German Shepherd Dog- Mix</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Staffordshire Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>English Setter-Dalmatian Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Nova Scotia Duck Tolling Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Standard Schnauzer</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Coton de Tulear</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Shih Tzu-Poodle Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Bichon Frise-Poodle Mix</td>
    </tr>
    <tr>
        <td>Border Collie-Brittany Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Nova Scotia Duck Tolling Retriever</td>
    </tr>
    <tr>
        <td>Newfoundland</td>
    </tr>
    <tr>
        <td>Shih Tzu-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu-Silky Terrier Mix</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu-Poodle Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Airedale Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Bull Terrier</td>
    </tr>
    <tr>
        <td>Clumber Spaniel</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Doberman Pinscher Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Maltese Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Bull Terrier-Whippet Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chesapeake Bay Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Poodle Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>St. Bernard</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Chihuahua-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Dutch Shepherd</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Smooth Fox Terrier</td>
    </tr>
    <tr>
        <td>Pointer-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Belgian Malinois- Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Briard</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Karelian Bear Dog</td>
    </tr>
    <tr>
        <td>Japanese Chin</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Nova Scotia Duck Tolling Retriever</td>
    </tr>
    <tr>
        <td>Belgian Sheepdog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Siberian Husky-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Greyhound Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua- Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chesapeake Bay Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Leonberger</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Irish Wolfhound-Great Dane Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Airedale Terrier-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Poodle Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Coton de Tulear</td>
    </tr>
    <tr>
        <td>American Eskimo Dog- Mix</td>
    </tr>
    <tr>
        <td>Border Collie-Beagle Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Coton de Tulear</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Brussels Griffon</td>
    </tr>
    <tr>
        <td>Welsh Springer Spaniel</td>
    </tr>
    <tr>
        <td>Lagotto Romagnolo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Beagle-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Black Russian Terrier</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Cardigan Welsh Corgi-Cairn Terrier Mix</td>
    </tr>
    <tr>
        <td>American English Coonhound-Weimaraner Mix</td>
    </tr>
    <tr>
        <td>Dalmatian-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Brussels Griffon</td>
    </tr>
    <tr>
        <td>Basenji-Shiba Inu Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>St. Bernard</td>
    </tr>
    <tr>
        <td>Chihuahua-Wire Fox Terrier Mix</td>
    </tr>
    <tr>
        <td>Newfoundland</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Siberian Husky-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Chow Chow Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Afghan Hound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Shorkie</td>
    </tr>
    <tr>
        <td>Boxer-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Boxer- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Silky Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Mastiff</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Keeshond</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Toy Fox Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>-Otterhound Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Spanish Water Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Shih Tzu-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Airedale Terrier Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Chesapeake Bay Retriever</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Eurasier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Kerry Blue Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever-Chow Chow Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Poodle-Maltese Mix</td>
    </tr>
    <tr>
        <td>Beauceron</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Great Pyrenees</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Clumber Spaniel</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Maltese Mix</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Central Asian Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Beagle-Whippet Mix</td>
    </tr>
    <tr>
        <td>Whippet</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua-Miniature Pinscher Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Poodle-Miniature Schnauzer Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Entlebucher Mountain Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Irish Setter</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Hovawart</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>Spinone Italiano</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Beagle Mix</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Kerry Blue Terrier</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Border Collie-English Springer Spaniel Mix</td>
    </tr>
    <tr>
        <td>Poodle-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Kooikerhondje</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Border Collie-Boxer Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Irish Setter-Poodle Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Boykin Spaniel- Mix</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Chinese Shar-Pei</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Poodle-Miniature Schnauzer Mix</td>
    </tr>
    <tr>
        <td>Chinook</td>
    </tr>
    <tr>
        <td>Tibetan Terrier</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Bullmastiff-Boxer Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Bloodhound Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Airedale Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Afghan Hound-Border Collie Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Treeing Walker Coonhound-English Foxhound Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>French Spaniel</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Black and Tan Coonhound</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Lhasa Apso-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Miniature Pinscher-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cardigan Welsh Corgi-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Shih Tzu-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Bullmastiff-Staffordshire Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Berger Picard</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Beagle Mix</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog- Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Labrador Retriever-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Samoyed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Samoyed</td>
    </tr>
    <tr>
        <td>Collie-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Boykin Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Alaskan Malamute</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Giant Schnauzer</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Belgian Tervuren</td>
    </tr>
    <tr>
        <td>English Setter</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Weimaraner Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Alaskan Malamute Mix</td>
    </tr>
    <tr>
        <td>Basenji</td>
    </tr>
    <tr>
        <td>Tibetan Spaniel</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Cardigan Welsh Corgi-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mastiff</td>
    </tr>
    <tr>
        <td>Rottweiler-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Lhasa Apso</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>-Pomeranian Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu- Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog- Mix</td>
    </tr>
    <tr>
        <td>Komondor</td>
    </tr>
    <tr>
        <td>Bouvier des Flandres</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Beagle-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>English Setter</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Lhasa Apso</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Akita Mix</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>French Bulldog-Boston Terrier Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Chinese Shar-Pei</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Poodle Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Dutch Shepherd</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Border Collie- Mix</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Rat Terrier-Italian Greyhound Mix</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-Wire Fox Terrier Mix</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-American Staffordshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Belgian Sheepdog-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Kerry Blue Terrier</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>American Eskimo Dog-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Swedish Vallhund</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Bugg</td>
    </tr>
    <tr>
        <td>Small Munsterlander Pointer</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Lhasa Apso-Poodle Mix</td>
    </tr>
    <tr>
        <td>Bugg</td>
    </tr>
    <tr>
        <td>German Longhaired Pointer-Pointer Mix</td>
    </tr>
    <tr>
        <td>Silky Terrier</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Rat Terrier-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Belgian Malinois Mix</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Italian Greyhound-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Swedish Vallhund</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Terrier</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>French Bulldog-Pug Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Beagle-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>-Great Pyrenees Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bullmastiff-Chinese Shar-Pei Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Kooikerhondje</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Pekingese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Nova Scotia Duck Tolling Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Norwegian Elkhound</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Great Dane Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Lhasa Apso</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Shih Tzu-Maltese Mix</td>
    </tr>
    <tr>
        <td>Chihuahua-Schipperke Mix</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Cardigan Welsh Corgi</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Newfoundland</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Dachshund-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chow Chow-Collie Mix</td>
    </tr>
    <tr>
        <td>Poodle-Standard Schnauzer Mix</td>
    </tr>
    <tr>
        <td>Lhasa Apso-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Doberman Pinscher-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chinese Shar-Pei- Mix</td>
    </tr>
    <tr>
        <td>Bearded Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Canaan Dog</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Staffordshire Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Standard Schnauzer-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Siberian Husky- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Doberman Pinscher Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Pomapoo</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Dogo Argentino</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Black Russian Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese-Lhasa Apso Mix</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Rottweiler-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>-American Eskimo Dog Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>American Water Spaniel</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bulldog-Boxer Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Dachshund-Rat Terrier Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Dalmatian Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Miniature Pinscher Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Black and Tan Coonhound Mix</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Brittany-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Beagle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Manchester Terrier-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>-Pomeranian Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Shih Tzu-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle-Pekingese Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Border Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Mastiff</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Neapolitan Mastiff Mix</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Cardigan Welsh Corgi Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pekingese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Cairn Terrier-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug-Brussels Griffon Mix</td>
    </tr>
    <tr>
        <td>-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Great Dane Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Collie Mix</td>
    </tr>
    <tr>
        <td>Collie-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Bloodhound-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Leonberger</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Lagotto Romagnolo</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>-Great Dane Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier- Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever-American Staffordshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Airedale Terrier</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Great Pyrenees</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Papillon-American Eskimo Dog Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Affenpinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Old English Sheepdog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Afghan Hound</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Chinook</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Stabyhoun Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rat Terrier-Parson Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Pembroke Welsh Corgi Mix</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Boykin Spaniel</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Scottish Deerhound-Saluki Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Chow Chow Mix</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-Chinese Shar-Pei Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Longhaired Pointer</td>
    </tr>
    <tr>
        <td>Standard Schnauzer</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Leonberger</td>
    </tr>
    <tr>
        <td>Labrador Retriever-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Siberian Husky-Border Collie Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>-Polish Lowland Sheepdog Mix</td>
    </tr>
    <tr>
        <td>Chihuahua-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Greyhound-Bedlington Terrier Mix</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pointer</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Spanish Water Dog</td>
    </tr>
    <tr>
        <td>Akita</td>
    </tr>
    <tr>
        <td>-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Pomeranian-Pekingese Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever-Nova Scotia Duck Tolling Retriever Mix</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Border Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Lagotto Romagnolo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Irish Setter</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Rat Terrier-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Belgian Tervuren-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Tibetan Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boykin Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beaglier</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Chihuahua-Pembroke Welsh Corgi Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Basenji Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rat Terrier-Beagle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Otterhound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-American Leopard Hound Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Chihuahua-Cairn Terrier Mix</td>
    </tr>
    <tr>
        <td>Pomapoo</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Afghan Hound</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Chinese Crested</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Great Pyrenees</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Border Collie-Irish Water Spaniel Mix</td>
    </tr>
    <tr>
        <td>Beagle-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Poodle-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Poodle Mix</td>
    </tr>
    <tr>
        <td>Redbone Coonhound-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer-Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Boxer Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Scottish Terrier</td>
    </tr>
    <tr>
        <td>Bloodhound-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Dachshund- Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mastiff</td>
    </tr>
    <tr>
        <td>St. Bernard</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Bullmastiff</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Canaan Dog</td>
    </tr>
    <tr>
        <td>Mastiff</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Boxer-Dalmatian Mix</td>
    </tr>
    <tr>
        <td>Bullmastiff- Mix</td>
    </tr>
    <tr>
        <td>Pointer-Parson Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Siberian Husky-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Lhasa Apso</td>
    </tr>
    <tr>
        <td>Bearded Collie</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Borzoi</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Schipperke</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Whippet</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Bichon Frise- Mix</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Chinese Crested</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua-Miniature Pinscher Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Border Collie-Staffordshire Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Border Terrier-Staffordshire Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Manchester Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Alaskan Malamute</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Akita-Afghan Hound Mix</td>
    </tr>
    <tr>
        <td>Lhasa Apso</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Bichon Frise-Poodle Mix</td>
    </tr>
    <tr>
        <td>Airedale Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Whippet Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Border Collie-English Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog- Mix</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Field Spaniel</td>
    </tr>
    <tr>
        <td>Keeshond</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Collie Mix</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Pug-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Smooth Fox Terrier-Whippet Mix</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Pointer-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Tibetan Terrier</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Samoyed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Labrador Retriever-English Springer Spaniel Mix</td>
    </tr>
    <tr>
        <td>Bull Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Irish Setter</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cardigan Welsh Corgi-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Beagle-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Akita</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Tibetan Terrier</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Norwegian Buhund</td>
    </tr>
    <tr>
        <td>Maltese-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Chihuahua-Pomeranian Mix</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Border Terrier-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>-Border Collie Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Bullmastiff Mix</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise-West Highland White Terrier Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Belgian Sheepdog-Dutch Shepherd Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Bedlington Terrier</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog- Mix</td>
    </tr>
    <tr>
        <td>Greyhound-Saluki Mix</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Havanese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Brittany-English Springer Spaniel Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu-Poodle Mix</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Appenzeller Sennenhunde</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Maltese- Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Chow Chow Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Shorkie</td>
    </tr>
    <tr>
        <td>Standard Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>St. Bernard-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Tosa- Mix</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Siberian Husky-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Alaskan Malamute</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Newfoundland-Bergamasco Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-West Highland White Terrier Mix</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Shih Tzu-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Appenzeller Sennenhunde-Collie Mix</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Greyhound-Scottish Deerhound Mix</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Anatolian Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Belgian Malinois-Dutch Shepherd Mix</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Irish Setter</td>
    </tr>
    <tr>
        <td>German Spitz</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Poodle-Miniature Schnauzer Mix</td>
    </tr>
    <tr>
        <td>Grand Basset Griffon Vendeen- Mix</td>
    </tr>
    <tr>
        <td>Vizsla- Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mastiff</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Norwegian Buhund</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle-Bluetick Coonhound Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chow Chow</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Cirneco dell&quot;Etna</td>
    </tr>
    <tr>
        <td>Basenji</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Chinese Shar-Pei Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Akita</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Scottish Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Boxer-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Welsh Springer Spaniel</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Chihuahua- Mix</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise-Cavalier King Charles Spaniel Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Border Collie-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier</td>
    </tr>
    <tr>
        <td>Poodle-Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Beagle-Pug Mix</td>
    </tr>
    <tr>
        <td>Dachshund-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Irish Setter</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Border Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Welsh Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Whippet</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Lhasa Apso</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier-Rat Terrier Mix</td>
    </tr>
    <tr>
        <td>-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Chihuahua-Miniature Pinscher Mix</td>
    </tr>
    <tr>
        <td>Small Munsterlander Pointer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Norfolk Terrier-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Chesapeake Bay Retriever</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier- Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Field Spaniel Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Border Terrier-Lakeland Terrier Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier-Rhodesian Ridgeback Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-English Springer Spaniel Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Lhasa Apso-Poodle Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Lhasa Apso Mix</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Maltese-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Greyhound-Whippet Mix</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rat Terrier-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Poodle Mix</td>
    </tr>
    <tr>
        <td>Petit Basset Griffon Vendeen</td>
    </tr>
    <tr>
        <td>Rat Terrier-Beagle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>-Cavalier King Charles Spaniel Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Rottweiler-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Chihuahua-Pembroke Welsh Corgi Mix</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Dandie Dinmont Terrier-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Thai Ridgeback</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Border Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mastiff</td>
    </tr>
    <tr>
        <td>Basset Hound-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier- Mix</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Bichon Frise-Cavalier King Charles Spaniel Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Whippet-Saluki Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Great Dane-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer-Boston Terrier Mix</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Maltese-Tibetan Spaniel Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Affenpinscher-Afghan Hound Mix</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Shih Tzu-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Dogue de Bordeaux</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Border Terrier- Mix</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Greyhound Mix</td>
    </tr>
    <tr>
        <td>Poodle-Border Collie Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Alaskan Malamute</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Golden Retriever-St. Bernard Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Border Collie-English Springer Spaniel Mix</td>
    </tr>
    <tr>
        <td>Border Collie-English Springer Spaniel Mix</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Collie Mix</td>
    </tr>
    <tr>
        <td>Border Collie-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Border Collie-Shetland Sheepdog Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Black Russian Terrier</td>
    </tr>
    <tr>
        <td>Chinese Shar-Pei</td>
    </tr>
    <tr>
        <td>-Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Czechoslovakian Vlcak</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>West Highland White Terrier-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Italian Greyhound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua-Rat Terrier Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Standard Schnauzer</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Bloodhound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Xoloitzcuintli</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Siberian Husky-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Maltese-Wire Fox Terrier Mix</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Greater Swiss Mountain Dog</td>
    </tr>
    <tr>
        <td>Norwegian Elkhound</td>
    </tr>
    <tr>
        <td>Labrador Retriever-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Collie-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Russell Terrier-Miniature Pinscher Mix</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Dogo Argentino</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Greyhound-Staffordshire Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mastiff</td>
    </tr>
    <tr>
        <td>Chihuahua- Mix</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Lagotto Romagnolo</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Russell Terrier-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Giant Schnauzer</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Poodle-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Italian Greyhound</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Bloodhound-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier- Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Beagle-Pekingese Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Chihuahua-Maltese Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier- Mix</td>
    </tr>
    <tr>
        <td>Chinese Shar-Pei</td>
    </tr>
    <tr>
        <td>Golden Retriever-Great Pyrenees Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Cardigan Welsh Corgi-American Eskimo Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Newfoundland</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chow Chow-Collie Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Bearded Collie-Bernese Mountain Dog Mix</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>-Anatolian Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Briard</td>
    </tr>
    <tr>
        <td>Appenzeller Sennenhunde- Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Nova Scotia Duck Tolling Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Alaskan Malamute</td>
    </tr>
    <tr>
        <td>Smooth Fox Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Stabyhoun</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Pekingese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Dachshund-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Irish Setter-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Akita</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Afghan Hound-Bloodhound Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Wire Fox Terrier</td>
    </tr>
    <tr>
        <td>-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Border Collie-Collie Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Russell Terrier-Manchester Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Afghan Hound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Cavalier King Charles Spaniel Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Great Pyrenees</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Dachshund-Pug Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Border Collie-Beagle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dutch Shepherd-Appenzeller Sennenhunde Mix</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Pekingese-Pomeranian Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Hovawart</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Poodle-Cavalier King Charles Spaniel Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Shih Tzu- Mix</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Poodle-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>-Maltese Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Bichon Frise-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Samoyed</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Airedale Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Beaglier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Belgian Tervuren</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Boykin Spaniel</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua-Pomeranian Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Poodle-Miniature Schnauzer Mix</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Bugg</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Russell Terrier-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Lagotto Romagnolo</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beaglier</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boerboel</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Neapolitan Mastiff</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Kooikerhondje</td>
    </tr>
    <tr>
        <td>Affenpinscher</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Appenzeller Sennenhunde</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Chinese Shar-Pei-Boerboel Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Giant Schnauzer</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog- Mix</td>
    </tr>
    <tr>
        <td>Cirneco dell&quot;Etna</td>
    </tr>
    <tr>
        <td>Havanese-Chinese Crested Mix</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mudi</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>German Spitz</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Spitz</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Spitz</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Tibetan Mastiff</td>
    </tr>
    <tr>
        <td>Briard</td>
    </tr>
    <tr>
        <td>-Poodle Mix</td>
    </tr>
    <tr>
        <td>Braque du Bourbonnais</td>
    </tr>
    <tr>
        <td>Coton de Tulear</td>
    </tr>
    <tr>
        <td>Havanese-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Dachshund-Scottish Terrier Mix</td>
    </tr>
    <tr>
        <td>Irish Red and White Setter</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Tibetan Spaniel</td>
    </tr>
    <tr>
        <td>Affenpinscher-American English Coonhound Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Russian Toy</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Cairn Terrier Mix</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Manchester Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chinese Shar-Pei- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Alaskan Malamute</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Nova Scotia Duck Tolling Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Collie- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Pug- Mix</td>
    </tr>
    <tr>
        <td>Greater Swiss Mountain Dog</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Airedale Terrier-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-Belgian Sheepdog Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Italian Greyhound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>BullBoxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Beaglier</td>
    </tr>
    <tr>
        <td>Border Collie-Dalmatian Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Mastiff-American Staffordshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback-Great Dane Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Nova Scotia Duck Tolling Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Finnish Lapphund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Beaglier</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Border Collie-Field Spaniel Mix</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Chinese Crested</td>
    </tr>
    <tr>
        <td>Lagotto Romagnolo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Siberian Husky-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beaglier</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Shih Tzu-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Belgian Tervuren</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Gordon Setter- Mix</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Irish Red and White Setter Mix</td>
    </tr>
    <tr>
        <td>Affenpinscher-Alaskan Malamute Mix</td>
    </tr>
    <tr>
        <td>Russell Terrier-Wire Fox Terrier Mix</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Cairn Terrier-West Highland White Terrier Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Eurasier</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Hovawart</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel-Papillon Mix</td>
    </tr>
    <tr>
        <td>Norwich Terrier- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Airedale Terrier</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Alaskan Malamute- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Scottish Terrier</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Airedale Terrier</td>
    </tr>
    <tr>
        <td>Wire Fox Terrier</td>
    </tr>
    <tr>
        <td>Miniature American Shepherd</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Belgian Tervuren</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Tibetan Terrier</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Boerboel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Coton de Tulear</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Scottish Terrier</td>
    </tr>
    <tr>
        <td>Russell Terrier-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Appenzeller Sennenhunde-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Cane Corso</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Airedale Terrier</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Shih Tzu-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Anatolian Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Airedale Terrier</td>
    </tr>
    <tr>
        <td>Bergamasco-Old English Sheepdog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Maltese-Silky Terrier Mix</td>
    </tr>
    <tr>
        <td>Standard Schnauzer</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Irish Water Spaniel</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Manchester Terrier</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Chinese Shar-Pei</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Beaglier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Pyrenean Shepherd</td>
    </tr>
    <tr>
        <td>Dutch Shepherd</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Collie-German Shorthaired Pointer Mix</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Standard Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cardigan Welsh Corgi-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Chihuahua-Papillon Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Standard Schnauzer</td>
    </tr>
    <tr>
        <td>Pekingese</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Spitz-Pomeranian Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Pug-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Dogue de Bordeaux</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Bearded Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog-Poodle Mix</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>St. Bernard</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu-Maltese Mix</td>
    </tr>
    <tr>
        <td>Chihuahua-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Entlebucher Mountain Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>West Highland White Terrier-Lhasa Apso Mix</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Neapolitan Mastiff</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Deutscher Wachtelhund- Mix</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Welsh Terrier</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog- Mix</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Keeshond</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Old English Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Affenpinscher</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Entlebucher Mountain Dog</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Tibetan Spaniel-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Boxer-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Icelandic Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Portuguese Pointer</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>West Highland White Terrier-Lhasa Apso Mix</td>
    </tr>
    <tr>
        <td>Border Collie-Flat-Coated Retriever Mix</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Greyhound Mix</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Vizsla Mix</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Thai Ridgeback</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Pekingese-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Anatolian Shepherd Dog-Mastiff Mix</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Greater Swiss Mountain Dog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Rat Terrier-Lancashire Heeler Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Pug-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Spinone Italiano</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Alaskan Malamute</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>English Springer Spaniel-Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Norwich Terrier</td>
    </tr>
    <tr>
        <td>Lhasa Apso</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Gordon Setter</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>English Setter- Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Cardigan Welsh Corgi Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Japanese Chin</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pekingese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Poodle Mix</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Alaskan Malamute</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Boxer Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Italian Greyhound</td>
    </tr>
    <tr>
        <td>Alaskan Malamute-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Maltese-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Komondor</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Wirehaired Pointer</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Irish Setter</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Pomapoo</td>
    </tr>
    <tr>
        <td>Japanese Chin-Papillon Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Havanese-Maltese Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Chow Chow Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Dachshund-Parson Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Lhasa Apso</td>
    </tr>
    <tr>
        <td>Chinese Shar-Pei</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier- Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Dutch Shepherd</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Great Pyrenees-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Chow Chow-Newfoundland Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Beagle Mix</td>
    </tr>
    <tr>
        <td>Boerboel</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Chow Chow</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>English Foxhound-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bearded Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Pomeranian-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Boxer-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Bichon Frise-Poodle Mix</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Miniature American Shepherd</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Border Collie Mix</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mastiff-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Greyhound-Whippet Mix</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Poodle Mix</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Basenji</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd- Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Miniature American Shepherd</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Akita</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Italian Greyhound</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Bulldog-Bullmastiff Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Drentsche Patrijshond</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boston Terrier-French Bulldog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Miniature Schnauzer Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Peruvian Inca Orchid</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Portuguese Podengo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Whippet</td>
    </tr>
    <tr>
        <td>Beagle-Rat Terrier Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Irish Setter-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>American Foxhound</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Boxer-American Staffordshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog-English Springer Spaniel Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Golden Retriever-Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Poodle Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu-Poodle Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Golden Retriever-Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>-Boxer Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Border Collie- Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-Doberman Pinscher Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Cardigan Welsh Corgi-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Siberian Husky-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pomeranian-Papillon Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Beauceron</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Scottish Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Bull Terrier-Staffordshire Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Boxer Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Spitz</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>St. Bernard</td>
    </tr>
    <tr>
        <td>Labrador Retriever-German Shorthaired Pointer Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Bluetick Coonhound Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu-Poodle Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Akita</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-Parson Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Labrador Retriever-English Springer Spaniel Mix</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mastiff</td>
    </tr>
    <tr>
        <td>Bull Terrier</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Belgian Sheepdog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Sloughi-Greyhound Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Chihuahua-Miniature Pinscher Mix</td>
    </tr>
    <tr>
        <td>Chihuahua-Pomeranian Mix</td>
    </tr>
    <tr>
        <td>Greater Swiss Mountain Dog-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Shih Tzu-Maltese Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever- Mix</td>
    </tr>
    <tr>
        <td>Norfolk Terrier</td>
    </tr>
    <tr>
        <td>German Wirehaired Pointer</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Cane Corso</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Black and Tan Coonhound-Plott Mix</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Canaan Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Canaan Dog</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Old English Sheepdog</td>
    </tr>
    <tr>
        <td>Russell Terrier-Beagle Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chinese Crested</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bull Terrier</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Plott</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu-Poodle Mix</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Brittany Mix</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Shorkie</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>St. Bernard-Greater Swiss Mountain Dog Mix</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Irish Red and White Setter</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Border Collie-Flat-Coated Retriever Mix</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Brussels Griffon-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Boxer Mix</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Poodle-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dogue de Bordeaux</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Great Dane-Rhodesian Ridgeback Mix</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Eurasier</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Maltese-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Bulldog-Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Labrador Retriever-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shorkie</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>-Poodle Mix</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Boxer Mix</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>American Foxhound-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>-Maltese Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Basset Hound-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Beagle Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Siberian Husky-Rhodesian Ridgeback Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Russell Terrier-Rat Terrier Mix</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Greyhound Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever- Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Pekingese-Pug Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Silky Terrier Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Poodle-Maltese Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Siberian Husky-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>American Eskimo Dog-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Italian Greyhound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Shorkie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Labrador Retriever- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Boxer Mix</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel-Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu-Poodle Mix</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-Boxer Mix</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Pug-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Dogue de Bordeaux</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Havanese- Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Lhasa Apso- Mix</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel-Beagle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Bulldog Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Bullmastiff-Redbone Coonhound Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Gordon Setter</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>St. Bernard</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Russell Terrier-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Chinese Crested</td>
    </tr>
    <tr>
        <td>Great Pyrenees</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Pekingese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Cardigan Welsh Corgi</td>
    </tr>
    <tr>
        <td>Beagle-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Lagotto Romagnolo-Berger Picard Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Chinese Shar-Pei Mix</td>
    </tr>
    <tr>
        <td>Beagle- Mix</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Poodle Mix</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Schipperke</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Italian Greyhound</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Boxer Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Chesapeake Bay Retriever Mix</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Chihuahua-Doberman Pinscher Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Shih Tzu-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Plott</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Rat Terrier-Parson Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Brussels Griffon</td>
    </tr>
    <tr>
        <td>Shih Tzu-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Tibetan Terrier</td>
    </tr>
    <tr>
        <td>Pomeranian-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Alaskan Malamute-Border Collie Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Lhasa Apso</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Pekingese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Basset Hound-Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Chihuahua-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Beagle-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Chihuahua-Pomeranian Mix</td>
    </tr>
    <tr>
        <td>Samoyed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Brussels Griffon</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog-American Leopard Hound Mix</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Japanese Chin</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Collie- Mix</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund-Beagle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pomapoo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>St. Bernard</td>
    </tr>
    <tr>
        <td>Australian Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>German Shepherd Dog- Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer- Mix</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi-Rat Terrier Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>American Eskimo Dog-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Russell Terrier-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Beagle Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rat Terrier-Chinese Shar-Pei Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Clumber Spaniel</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Chinese Shar-Pei</td>
    </tr>
    <tr>
        <td>Greater Swiss Mountain Dog</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Bouvier des Flandres</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>St. Bernard-Black and Tan Coonhound Mix</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Border Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Border Collie-Lancashire Heeler Mix</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Tibetan Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Swedish Vallhund</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Pekingese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Old English Sheepdog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>American Foxhound</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Great Pyrenees-Welsh Springer Spaniel Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Bull Terrier</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Gordon Setter</td>
    </tr>
    <tr>
        <td>Gordon Setter</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Whippet</td>
    </tr>
    <tr>
        <td>Cardigan Welsh Corgi-Pomeranian Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Shiba Inu-Beagle Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Akita</td>
    </tr>
    <tr>
        <td>Border Collie-Miniature Pinscher Mix</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Alaskan Malamute</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua-Dachshund Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Poodle-Maltese Mix</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Maltese-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Poodle-Pekingese Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Standard Schnauzer-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Pinscher-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Silky Terrier Mix</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Bulldog-Beagle Mix</td>
    </tr>
    <tr>
        <td>-Cavalier King Charles Spaniel Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beauceron</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Standard Schnauzer</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>French Bulldog-Staffordshire Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Boxer-Jindo Mix</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Whippet</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Pekingese</td>
    </tr>
    <tr>
        <td>English Springer Spaniel-Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bullmastiff-Staffordshire Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Shiba Inu Mix</td>
    </tr>
    <tr>
        <td>Bull Terrier</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Black and Tan Coonhound-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Belgian Tervuren</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Bolognese</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua-Italian Greyhound Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Border Collie-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua-Parson Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Chow Chow Mix</td>
    </tr>
    <tr>
        <td>Boston Terrier-Pug Mix</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>St. Bernard-Great Pyrenees Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Russian Toy</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Airedale Terrier</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Border Collie-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Shih Tzu-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Poodle-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Bugg</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Skye Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Bichon Frise-Cavalier King Charles Spaniel Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>Akita- Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pekingese-Tibetan Spaniel Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>-Rhodesian Ridgeback Mix</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Belgian Tervuren</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Whippet</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Bluetick Coonhound-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier</td>
    </tr>
    <tr>
        <td>Chihuahua-Papillon Mix</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Basset Hound-Beagle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Irish Wolfhound</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Great Pyrenees</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle-Bulldog Mix</td>
    </tr>
    <tr>
        <td>Chesapeake Bay Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Siberian Husky-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Labrador Retriever-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Bullmastiff-American Staffordshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Tibetan Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua-Airedale Terrier Mix</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>English Springer Spaniel-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever-St. Bernard Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier- Mix</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Golden Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Polish Lowland Sheepdog</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Pointer</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>Pug-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Lakeland Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Bull Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Maltese-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer-Jindo Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever- Mix</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Basenji</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Chow Chow Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Coton de Tulear</td>
    </tr>
    <tr>
        <td>English Setter</td>
    </tr>
    <tr>
        <td>Golden Retriever-Collie Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Weimaraner Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Siberian Husky-Standard Schnauzer Mix</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Newfoundland</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Boxer-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu-Poodle Mix</td>
    </tr>
    <tr>
        <td>Chihuahua-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Chinese Crested</td>
    </tr>
    <tr>
        <td>Welsh Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Anatolian Shepherd Dog-Great Pyrenees Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Chinese Shar-Pei</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Belgian Tervuren</td>
    </tr>
    <tr>
        <td>Belgian Tervuren</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>English Setter</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise-Pomeranian Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Field Spaniel</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Beagle Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Belgian Malinois-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Briard</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Havanese-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Italian Greyhound</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Pembroke Welsh Corgi Mix</td>
    </tr>
    <tr>
        <td>Poodle-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-Bullmastiff Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Belgian Malinois-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Poodle-Lhasa Apso Mix</td>
    </tr>
    <tr>
        <td>Irish Setter</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Italian Greyhound</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Boxer Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Petit Basset Griffon Vendeen</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Chihuahua-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Beagle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Treeing Walker Coonhound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle-Chow Chow Mix</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Coton de Tulear</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Beagle-Smooth Fox Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Basenji-American Staffordshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer-American Staffordshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Border Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>Chihuahua-Rat Terrier Mix</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>German Wirehaired Pointer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Samoyed</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Samoyed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Shetland Sheepdog Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Maltese-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Siberian Husky-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Airedale Terrier-German Shorthaired Pointer Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Berger Picard</td>
    </tr>
    <tr>
        <td>Lakeland Terrier</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Cairn Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Papillon-Maltese Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Dutch Shepherd</td>
    </tr>
    <tr>
        <td>Dutch Shepherd</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Bouvier des Flandres</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-Kooikerhondje Mix</td>
    </tr>
    <tr>
        <td>Akita</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Pembroke Welsh Corgi Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Miniature American Shepherd</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Bichon Frise-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Beagle-Pekingese Mix</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-German Wirehaired Pointer Mix</td>
    </tr>
    <tr>
        <td>Chihuahua-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Chow Chow</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Beagle-Basset Hound Mix</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Treeing Walker Coonhound</td>
    </tr>
    <tr>
        <td>Shih Tzu-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-Chow Chow Mix</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rottweiler-Border Collie Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Dachshund-Beagle Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Australian Terrier-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Finnish Lapphund</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>American Water Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Bull Terrier-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle-Pekingese Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Great Pyrenees Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Curly-Coated Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Rhodesian Ridgeback Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel-Pomeranian Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Poodle-Miniature Schnauzer Mix</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Border Collie-Newfoundland Mix</td>
    </tr>
    <tr>
        <td>Newfoundland</td>
    </tr>
    <tr>
        <td>Bolognese</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Smooth Fox Terrier-Whippet Mix</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Tibetan Terrier</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Siberian Husky-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Dachshund-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Greyhound-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Pekingese</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Italian Greyhound-Rat Terrier Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>English Setter-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Maltese Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Beagle-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Doberman Pinscher-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Pointer Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Wirehaired Pointer</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Xoloitzcuintli</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Wire Fox Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Xoloitzcuintli</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Scottish Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle-Maltese Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-American Staffordshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle-Weimaraner Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Bearded Collie</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>American Water Spaniel</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Curly-Coated Retriever</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua-Cardigan Welsh Corgi Mix</td>
    </tr>
    <tr>
        <td>Whippet</td>
    </tr>
    <tr>
        <td>Whippet</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Redbone Coonhound-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Small Munsterlander Pointer</td>
    </tr>
    <tr>
        <td>Maltese-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beauceron</td>
    </tr>
    <tr>
        <td>Beauceron</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Briard</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Chihuahua-Miniature Pinscher Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Basenji</td>
    </tr>
    <tr>
        <td>Siberian Husky-American Staffordshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Golden Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Chihuahua-Pug Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise-Cavalier King Charles Spaniel Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Giant Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Beauceron</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Italian Greyhound</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Bichon Frise-Poodle Mix</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog</td>
    </tr>
    <tr>
        <td>Wire Fox Terrier</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Beagle-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Rat Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Poodle-Maltese Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Bearded Collie</td>
    </tr>
    <tr>
        <td>Mastiff</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Australian Terrier</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Border Collie Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Schipperke</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Siberian Husky-Bloodhound Mix</td>
    </tr>
    <tr>
        <td>Icelandic Sheepdog</td>
    </tr>
    <tr>
        <td>Tibetan Spaniel</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Pomeranian-Papillon Mix</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Norwegian Elkhound Mix</td>
    </tr>
    <tr>
        <td>Deutscher Wachtelhund</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Russell Terrier- Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier- Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Pomeranian-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Alaskan Malamute</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Anatolian Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever- Mix</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Russell Terrier-Parson Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Chinese Shar-Pei-Basset Hound Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Spanish Mastiff</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Chihuahua-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Bullmastiff Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Irish Wolfhound-Scottish Deerhound Mix</td>
    </tr>
    <tr>
        <td>Dachshund-Miniature Pinscher Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Neapolitan Mastiff</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Manchester Terrier-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Schipperke</td>
    </tr>
    <tr>
        <td>Poodle-Maltese Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Silky Terrier</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Poodle-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Doberman Pinscher Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Great Pyrenees</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Harrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Lhasa Apso-Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>Pug-Lhasa Apso Mix</td>
    </tr>
    <tr>
        <td>Boxer-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Whippet</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Shorkie</td>
    </tr>
    <tr>
        <td>Rottweiler-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Bluetick Coonhound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback-Boston Terrier Mix</td>
    </tr>
    <tr>
        <td>Bearded Collie</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Chinese Crested</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-Rhodesian Ridgeback Mix</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Shih Tzu-Pomeranian Mix</td>
    </tr>
    <tr>
        <td>Tibetan Spaniel</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Boxer Mix</td>
    </tr>
    <tr>
        <td>Chinese Crested</td>
    </tr>
    <tr>
        <td>Silky Terrier</td>
    </tr>
    <tr>
        <td>Tibetan Terrier</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Akita</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chinese Shar-Pei</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund-French Bulldog Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Australian Terrier</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Boxer-Akita Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Black and Tan Coonhound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Field Spaniel</td>
    </tr>
    <tr>
        <td>Alaskan Malamute</td>
    </tr>
    <tr>
        <td>shih tzu</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog-Collie Mix</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labrador Retriever-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Whippet</td>
    </tr>
    <tr>
        <td>Old English Sheepdog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Russell Terrier-Miniature Schnauzer Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Labrador Retriever-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Briard</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Lhasa Apso-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Akita</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Afghan Hound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Dalmatian Mix</td>
    </tr>
    <tr>
        <td>Bedlington Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Boxer-Mastiff Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Jack-A-Poo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Akita-Afghan Hound Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-American Staffordshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer-Whippet Mix</td>
    </tr>
    <tr>
        <td>American Foxhound</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Chow Chow-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Beagle-Basset Hound Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Basenji-American Water Spaniel Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Standard Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mastiff</td>
    </tr>
    <tr>
        <td>Pomeranian-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise-Poodle Mix</td>
    </tr>
    <tr>
        <td>Afghan Hound-Airedale Terrier Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Afghan Hound</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Spinone Italiano</td>
    </tr>
    <tr>
        <td>Spinone Italiano</td>
    </tr>
    <tr>
        <td>Spinone Italiano</td>
    </tr>
    <tr>
        <td>Poodle-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Jack-A-Poo</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Cairn Terrier-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Pointer</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Terrier-Parson Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Old English Sheepdog-Poodle Mix</td>
    </tr>
    <tr>
        <td>Lhasa Apso-Keeshond Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Belgian Malinois-Chow Chow Mix</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Rat Terrier-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>West Highland White Terrier-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Labrador Retriever-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Great Pyrenees</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Vizsla Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Silky Terrier-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-Greyhound Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-Boston Terrier Mix</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier-Bullmastiff Mix</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Australian Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Standard Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Estrela Mountain Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Shih Tzu-Coton de Tulear Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Akita-Affenpinscher Mix</td>
    </tr>
    <tr>
        <td>Airedale Terrier-Portuguese Podengo Pequeno Mix</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cane Corso</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Cairn Terrier-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Dalmatian-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Pug-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog-Border Collie Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Boxer Mix</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Norfolk Terrier</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Affenpinscher-Poodle Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Boxer Mix</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Xoloitzcuintli</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>St. Bernard</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Belgian Malinois-American Staffordshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Boxer-English Springer Spaniel Mix</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Siberian Husky-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Xoloitzcuintli</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Lhasa Apso-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Puli</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Boxer Mix</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Toy Fox Terrier</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mastador</td>
    </tr>
    <tr>
        <td>Doberman Pinscher-Poodle Mix</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Finnish Lapphund</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Brussels Griffon-Pug Mix</td>
    </tr>
    <tr>
        <td>Anatolian Shepherd Dog</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Plott-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Nova Scotia Duck Tolling Retriever</td>
    </tr>
    <tr>
        <td>Silky Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Papillon-Pug Mix</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Whippet-Pointer Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Rhodesian Ridgeback Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Pinscher-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>St. Bernard</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Pomeranian-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>German Wirehaired Pointer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>BullBoxer</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Bouvier des Flandres</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cardigan Welsh Corgi</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Giant Schnauzer-Poodle Mix</td>
    </tr>
    <tr>
        <td>Bull Terrier-American Foxhound Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Italian Greyhound</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Alaskan Malamute</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Chesapeake Bay Retriever</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shorkie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Boxer Mix</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Belgian Tervuren</td>
    </tr>
    <tr>
        <td>Pug-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Pomeranian Mix</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Nova Scotia Duck Tolling Retriever</td>
    </tr>
    <tr>
        <td>Rat Terrier-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Chihuahua-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Wirehaired Pointing Griffon</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Scottish Terrier</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Cane Corso</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>Akita</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Belgian Tervuren</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Rhodesian Ridgeback Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Poodle-Rat Terrier Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Shetland Sheepdog Mix</td>
    </tr>
    <tr>
        <td>Siberian Husky-Beagle Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Pug Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Beagle-Rat Terrier Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Leonberger</td>
    </tr>
    <tr>
        <td>Chihuahua-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Pug-Pekingese Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Poodle-Giant Schnauzer Mix</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Irish Wolfhound</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Irish Terrier</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Irish Wolfhound</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Nova Scotia Duck Tolling Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bouvier des Flandres</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Australian Terrier-Lowchen Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu-Lhasa Apso Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Chinese Crested</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Pointer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Borzoi-Whippet Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Weimaraner Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Norwegian Elkhound</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Airedale Terrier-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Spanish Water Dog</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Dalmatian-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Labrador Retriever-German Shorthaired Pointer Mix</td>
    </tr>
    <tr>
        <td>Boxer-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Briard</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Labrador Retriever-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Greyhound-Pointer Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Bouvier des Flandres</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle-Rat Terrier Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Siberian Husky-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Coton de Tulear</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Shih Tzu-Maltese Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Airedale Terrier</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Alaskan Malamute</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Border Collie-Belgian Sheepdog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Toy Fox Terrier-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Siberian Husky-American Staffordshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-American English Coonhound Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Shih Tzu-Pomeranian Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Chesapeake Bay Retriever</td>
    </tr>
    <tr>
        <td>Maltese-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Great Dane Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Boxer-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Great Pyrenees</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Poodle Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Swedish Vallhund</td>
    </tr>
    <tr>
        <td>Border Collie-Staffordshire Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Shorkie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Siberian Husky-Bernese Mountain Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Borzoi</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback-Vizsla Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bullmastiff</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Irish Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Shorkie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Redbone Coonhound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Bloodhound-Black and Tan Coonhound Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cairn Terrier-Pomeranian Mix</td>
    </tr>
    <tr>
        <td>Manchester Terrier</td>
    </tr>
    <tr>
        <td>Scottish Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Old English Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Airedale Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Samoyed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Newfoundland</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Catahoula Leopard Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Samoyed</td>
    </tr>
    <tr>
        <td>Samoyed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Siberian Husky-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>German Wirehaired Pointer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu-Poodle Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise-Poodle Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>English Setter</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Bouvier des Flandres</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Schipperke</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>Belgian Malinois-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bull Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Affenpinscher-Brussels Griffon Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Great Dane Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Maltese-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Beagle-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Norwich Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Flat-Coated Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Chesapeake Bay Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Giant Schnauzer-American Eskimo Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-Miniature Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Beagle-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Mastiff Mix</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bulldog-Mastiff Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Bichon Frise-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-German Shorthaired Pointer Mix</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature American Shepherd</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Gordon Setter</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Weimaraner Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Weimaraner Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Newfoundland</td>
    </tr>
    <tr>
        <td>Samoyed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle-Miniature Schnauzer Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Basset Hound-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Irish Setter-Poodle Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pomapoo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Bullmastiff</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Welsh Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Jack-A-Poo</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Chow Chow Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Maltese-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Akita-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Welsh Terrier</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Bichon Frise-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Irish Setter</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cardigan Welsh Corgi-Lancashire Heeler Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Golden Retriever-Chow Chow Mix</td>
    </tr>
    <tr>
        <td>Standard Schnauzer-Poodle Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Miniature Schnauzer Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Keeshond-Chow Chow Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Beagle-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Great Pyrenees-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Black and Tan Coonhound-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Standard Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Alaskan Malamute</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Boxer Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Italian Greyhound</td>
    </tr>
    <tr>
        <td>Beagle-Poodle Mix</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Newfoundland</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Standard Schnauzer</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Russell Terrier-Rat Terrier Mix</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Miniature American Shepherd</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-Dogo Argentino Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Maltese-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Siberian Husky-Alaskan Malamute Mix</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Standard Poodle-Chinese Shar-Pei Mix</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Cairn Terrier-Airedale Terrier Mix</td>
    </tr>
    <tr>
        <td>Weimaraner-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Perro de Presa Canario</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Bugg</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Brussels Griffon</td>
    </tr>
    <tr>
        <td>Wirehaired Pointing Griffon</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Keeshond Mix</td>
    </tr>
    <tr>
        <td>Boxer-Poodle Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature American Shepherd</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Boxer Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Boxer-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Border Collie-Shetland Sheepdog Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Poodle Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Greyhound Mix</td>
    </tr>
    <tr>
        <td>Petit Basset Griffon Vendeen</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Alaskan Malamute</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pekingese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Cardigan Welsh Corgi</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature American Shepherd</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua-Pug Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Greyhound-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Border Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Rottweiler-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bedlington Terrier</td>
    </tr>
    <tr>
        <td>Boxer-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>St. Bernard-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Dachshund-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Bulldog-Boxer Mix</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Scottish Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Glen of Imaal Terrier</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Poodle-Pomeranian Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Havanese-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>American Hairless Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Brussels Griffon</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Miniature Pinscher Mix</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>German Wirehaired Pointer</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Italian Greyhound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Terrier-Cairn Terrier Mix</td>
    </tr>
    <tr>
        <td>Beagle-Shetland Sheepdog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Alaskan Malamute</td>
    </tr>
    <tr>
        <td>Standard Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Miniature Schnauzer Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Pekingese Mix</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Japanese Chin-Maltese Mix</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Tibetan Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Miniature Schnauzer Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Wire Fox Terrier</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Rhodesian Ridgeback Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Bearded Collie</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Belgian Sheepdog-Lhasa Apso Mix</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Standard Schnauzer</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Belgian Malinois-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Entlebucher Mountain Dog</td>
    </tr>
    <tr>
        <td>Entlebucher Mountain Dog</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chinese Shar-Pei</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>English Springer Spaniel-Dalmatian Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Great Pyrenees Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Chihuahua-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Chihuahua-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Tibetan Terrier</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Cardigan Welsh Corgi Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Shiba Inu Mix</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Scottish Terrier</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mastiff-Great Dane Mix</td>
    </tr>
    <tr>
        <td>Tibetan Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Beaglier</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Lhasa Apso-Maltese Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Poodle Mix</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Border Collie-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Lhasa Apso Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Lagotto Romagnolo</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Briard</td>
    </tr>
    <tr>
        <td>Beagle-Cavalier King Charles Spaniel Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Boxer-American Staffordshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Bichon Frise-Poodle Mix</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Finnish Lapphund</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Maltese-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>English Springer Spaniel-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Airedale Terrier</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Cavalier King Charles Spaniel Mix</td>
    </tr>
    <tr>
        <td>Chihuahua-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Basenji-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Boxer-Rhodesian Ridgeback Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bloodhound</td>
    </tr>
    <tr>
        <td>Bloodhound-Black and Tan Coonhound Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Golden Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Chihuahua-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Pug-Brussels Griffon Mix</td>
    </tr>
    <tr>
        <td>Bulldog-German Shorthaired Pointer Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bullmastiff-Bulldog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Boston Terrier-Beagle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Chesapeake Bay Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Beauceron</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Basenji-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Basset Hound-Airedale Terrier Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Chihuahua-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Great Pyrenees-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Great Pyrenees-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback-American Water Spaniel Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Russell Terrier-Wire Fox Terrier Mix</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>French Bulldog-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Basenji</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Newfoundland</td>
    </tr>
    <tr>
        <td>Shih Tzu-Border Collie Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Pointer Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Pumi</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Great Pyrenees</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Irish Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Siberian Husky-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Chihuahua-Whippet Mix</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Newfoundland</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Beagle-Cavalier King Charles Spaniel Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Silky Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback-Mastiff Mix</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Akita-Airedale Terrier Mix</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chinese Crested</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>American Eskimo Dog-English Springer Spaniel Mix</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Boxer-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Greater Swiss Mountain Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Maltese-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Pekingese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Rottweiler-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Bichon Frise-Poodle Mix</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Chow Chow Mix</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Coton de Tulear</td>
    </tr>
    <tr>
        <td>Pomapoo</td>
    </tr>
    <tr>
        <td>Puli</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Dogo Argentino-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Border Collie-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Canaan Dog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Bearded Collie</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Shiba Inu Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Rottweiler-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Maltese-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Basset Hound-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Lancashire Heeler-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boykin Spaniel-English Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>Komondor</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Lagotto Romagnolo</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Rottweiler-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-Boxer Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier-Rat Terrier Mix</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Beagle-American Eskimo Dog Mix</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Dutch Shepherd</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Chow Chow Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Wirehaired Pointing Griffon</td>
    </tr>
    <tr>
        <td>Wire Fox Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>American English Coonhound-Rhodesian Ridgeback Mix</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Border Collie-American Foxhound Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Siberian Husky-Chow Chow Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Chinese Shar-Pei</td>
    </tr>
    <tr>
        <td>Siberian Husky-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-West Highland White Terrier Mix</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Poodle Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Doberman Pinscher-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Miniature American Shepherd</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Giant Schnauzer</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Border Collie-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Border Collie-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Chihuahua-Beagle Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Brussels Griffon</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>German Wirehaired Pointer</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Russell Terrier-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Whippet</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Boston Terrier-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel-Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Poodle-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Maltese-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Australian Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Whippet-Beagle Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Border Collie Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Samoyed-Shetland Sheepdog Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Bull Terrier</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Toy Fox Terrier</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Maltese Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Collie Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu-Poodle Mix</td>
    </tr>
    <tr>
        <td>Danish-Swedish Farmdog</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Border Collie-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Samoyed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Chinook-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Maltese Mix</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>St. Bernard-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Spinone Italiano</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle-Soft Coated Wheaten Terrier Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Great Pyrenees</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Dachshund-Poodle Mix</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Schapendoes</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Doberman Pinscher Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise-Lhasa Apso Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Beagle-Bluetick Coonhound Mix</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Treeing Walker Coonhound</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Maltese-Cavalier King Charles Spaniel Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Toy Fox Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Maltese-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Old English Sheepdog</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Bull Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Great Pyrenees-Kuvasz Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer-Rhodesian Ridgeback Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Bichon Frise-Lhasa Apso Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Nova Scotia Duck Tolling Retriever-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-Boxer Mix</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Miniature Pinscher-Basenji Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-English Setter Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Poodle Mix</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog-Boxer Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Border Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Chihuahua-Pug Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Shih Tzu-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pyrenean Shepherd</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Poodle-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Collie-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Keeshond-American Eskimo Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Schipperke</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Mastiff-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Coton de Tulear</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Giant Schnauzer</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Greater Swiss Mountain Dog</td>
    </tr>
    <tr>
        <td>Coton de Tulear</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Miniature Schnauzer Mix</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Chihuahua-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Samoyed</td>
    </tr>
    <tr>
        <td>Silky Terrier-Lhasa Apso Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever-American Staffordshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Dachshund-Miniature Pinscher Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Old English Sheepdog</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Poodle-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug-Boston Terrier Mix</td>
    </tr>
    <tr>
        <td>Samoyed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Newfoundland</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua-Miniature Pinscher Mix</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Border Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Border Collie Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Border Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Coton de Tulear</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Beagle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer-Great Dane Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Whippet</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise-Cavalier King Charles Spaniel Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise-Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Shih Tzu-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bullmastiff</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Collie-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Boston Terrier-French Bulldog Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Maltese-Havanese Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Scottish Terrier</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Newfoundland</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Chinese Crested</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>American Eskimo Dog-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Border Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Bluetick Coonhound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Great Pyrenees</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Kooikerhondje</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Maltese-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Bluetick Coonhound</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Irish Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Dachshund-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Belgian Malinois-Dutch Shepherd Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Boxer-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Poodle-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Beagle-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Golden Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pointer</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Collie-Shetland Sheepdog Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Doberman Pinscher Mix</td>
    </tr>
    <tr>
        <td>Border Collie-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Poodle Mix</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-American Eskimo Dog Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Norwich Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Poodle-Miniature Schnauzer Mix</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Boxer Mix</td>
    </tr>
    <tr>
        <td>Norwich Terrier</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Border Collie Mix</td>
    </tr>
    <tr>
        <td>St. Bernard</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mastiff-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Weimaraner Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Beagle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Miniature Schnauzer Mix</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Chihuahua-Toy Fox Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chesapeake Bay Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Alaskan Malamute Mix</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Czechoslovakian Vlcak</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Boxer Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Rhodesian Ridgeback Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Manchester Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Collie-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Irish Setter-Poodle Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Dutch Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chow Chow-Catahoula Leopard Dog Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Dachshund-Maltese Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Maltese Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle-Treeing Walker Coonhound Mix</td>
    </tr>
    <tr>
        <td>Great Pyrenees</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Bichon Frise-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Chihuahua-Norwich Terrier Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>Chinese Shar-Pei</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Weimaraner Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Great Pyrenees Mix</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-Greyhound Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Boxer-Vizsla Mix</td>
    </tr>
    <tr>
        <td>Pekingese</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Maltese Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Alaskan Malamute</td>
    </tr>
    <tr>
        <td>Pyrenean Shepherd</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Briard</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Maltese-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Bedlington Terrier</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Weimaraner-Beagle Mix</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Cane Corso</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Pembroke Welsh Corgi Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Bichon Frise-Poodle Mix</td>
    </tr>
    <tr>
        <td>Bullmastiff-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Coton de Tulear</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>American Eskimo Dog-Shiba Inu Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Chihuahua-Maltese Mix</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Black and Tan Coonhound-Beagle Mix</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Polish Lowland Sheepdog</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Basenji-Whippet Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Setter</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Basset Hound-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Maltese Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Lhasa Apso-Poodle Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Border Terrier-West Highland White Terrier Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>German Pinscher</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Redbone Coonhound</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Beagle Mix</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Chihuahua-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Bullmastiff-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Leonberger</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Dachshund-Black Russian Terrier Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer-Catahoula Leopard Dog Mix</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Russell Terrier-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Poodle Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Maltese Mix</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Sussex Spaniel-English Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>Irish Wolfhound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Russell Terrier-Toy Fox Terrier Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Bichon Frise-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Labrador Retriever-American Staffordshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Wirehaired Vizsla</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Cardigan Welsh Corgi Mix</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Maltese-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Great Pyrenees</td>
    </tr>
    <tr>
        <td>Lhasa Apso-Poodle Mix</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier-Rat Terrier Mix</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature American Shepherd</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Chow Chow Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Poodle-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-German Longhaired Pointer Mix</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Airedale Terrier</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Maltese-Papillon Mix</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Pomeranian-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Russell Terrier-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Chinese Crested</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Shih Tzu-Lhasa Apso Mix</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Beaglier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Border Collie-Soft Coated Wheaten Terrier Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu-Poodle Mix</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Newfoundland</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>English Setter</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Great Pyrenees</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Poodle-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Leonberger</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Redbone Coonhound-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Poodle-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Maltese Mix</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Greyhound Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Rat Terrier-Papillon Mix</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Border Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Affenpinscher-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Great Dane Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Bulldog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Shih Tzu-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Chihuahua-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Beagle-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Catahoula Leopard Dog Mix</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Mastiff</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Chihuahua-Rat Terrier Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Poodle Mix</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Beauceron Mix</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Welsh Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Bloodhound Mix</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Border Collie-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu-Poodle Mix</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Small Munsterlander Pointer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-English Setter Mix</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>Shorkie</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Maltese Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Chihuahua-Pug Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Beagle-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Rottweiler-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Greyhound-Irish Wolfhound Mix</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise-Cavalier King Charles Spaniel Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Shih Tzu-Maltese Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua-Beagle Mix</td>
    </tr>
    <tr>
        <td>Border Collie-Shetland Sheepdog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Mastiff Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Boxer-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Irish Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Bouvier des Flandres</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Chihuahua-Cairn Terrier Mix</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel-Pekingese Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Beagle-Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Labrador Retriever-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Scottish Deerhound</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Poodle-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Plott-Beagle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Cavalier King Charles Spaniel Mix</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Shih Tzu-Lhasa Apso Mix</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Pekingese-Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise-Cavalier King Charles Spaniel Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Border Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Poodle-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Norwegian Elkhound</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bullmastiff</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Leonberger</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever-Portuguese Water Dog Mix</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Nova Scotia Duck Tolling Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Bouvier des Flandres</td>
    </tr>
    <tr>
        <td>Boxer-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Poodle-Miniature Schnauzer Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Nova Scotia Duck Tolling Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Samoyed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Boxer-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Setter</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Coton de Tulear</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Polish Lowland Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Miniature American Shepherd</td>
    </tr>
    <tr>
        <td>Newfoundland</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Maltese Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pomeranian-Toy Fox Terrier Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Border Collie-Boxer Mix</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cane Corso</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Miniature American Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Maltese-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Brussels Griffon</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Weimaraner Mix</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Golden Retriever-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Silky Terrier</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Russell Terrier-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Beauceron</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Mastiff Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Silky Terrier Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Pinscher-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>English Cocker Spaniel</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Border Collie-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Poodle Mix</td>
    </tr>
    <tr>
        <td>Chow Chow-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Poodle Mix</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Great Pyrenees-Bernese Mountain Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Collie Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Alaskan Malamute</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel-Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever-German Shorthaired Pointer Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Havanese-Maltese Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Airedale Terrier</td>
    </tr>
    <tr>
        <td>Italian Greyhound-Miniature Pinscher Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Brussels Griffon</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Catahoula Leopard Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle-Toy Fox Terrier Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Greater Swiss Mountain Dog</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Treeing Walker Coonhound-Parson Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Redbone Coonhound Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Whippet</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Whippet</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Old English Sheepdog-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Pomapoo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Doberman Pinscher Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chinese Crested-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Field Spaniel</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>Poodle-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Treeing Walker Coonhound-Pointer Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier-Maltese Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bullmastiff</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Bluetick Coonhound Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Pharaoh Hound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Silky Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Lhasa Apso</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Chinese Crested-Poodle Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Welsh Terrier-Miniature Schnauzer Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Papillon-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Doberman Pinscher Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Wire Fox Terrier-Parson Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-German Shorthaired Pointer Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua-Toy Fox Terrier Mix</td>
    </tr>
    <tr>
        <td>Karelian Bear Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Coton de Tulear-Poodle Mix</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Treeing Walker Coonhound</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Beagle-Parson Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Rottweiler-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Bearded Collie</td>
    </tr>
    <tr>
        <td>Brussels Griffon</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Papillon</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Papillon-German Spitz Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Karelian Bear Dog</td>
    </tr>
    <tr>
        <td>Scottish Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Lhasa Apso-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Basset Hound-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Great Pyrenees-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-St. Bernard Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>St. Bernard</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rat Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Chihuahua-Whippet Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cardigan Welsh Corgi-Beagle Mix</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever-Belgian Malinois Mix</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Samoyed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Tibetan Terrier</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Lhasa Apso</td>
    </tr>
    <tr>
        <td>Beagle-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bouvier des Flandres</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Alaskan Malamute</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Tosa</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Poodle Mix</td>
    </tr>
    <tr>
        <td>Bouvier des Flandres</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Belgian Malinois Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Alaskan Malamute-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Beagle-Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>Beagle-Parson Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Beagle-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Pointer Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Belgian Malinois Mix</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Dachshund-Pembroke Welsh Corgi Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Poodle-Old English Sheepdog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pomeranian-Rat Terrier Mix</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Border Collie-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rat Terrier-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>Boxer-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Brussels Griffon</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Glen of Imaal Terrier</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Jindo</td>
    </tr>
    <tr>
        <td>Tibetan Terrier</td>
    </tr>
    <tr>
        <td>Maltese-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Chihuahua-Papillon Mix</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier-Bullmastiff Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Boxer-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Chesapeake Bay Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mastiff-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Norwich Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Maltese-Miniature Schnauzer Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Maltese-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Poodle-Soft Coated Wheaten Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Siberian Husky-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Maltese Mix</td>
    </tr>
    <tr>
        <td>Poodle-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Rhodesian Ridgeback Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Belgian Malinois Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Siberian Husky Mix</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier-Cairn Terrier Mix</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bulldog-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Siberian Husky-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Brittany-German Shepherd Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Collie Mix</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Plott</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Boston Terrier-French Bulldog Mix</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Ibizan Hound-Greyhound Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog</td>
    </tr>
    <tr>
        <td>Lagotto Romagnolo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Akita</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Great Pyrenees Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Shih Tzu-Maltese Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Shih Tzu-Poodle Mix</td>
    </tr>
    <tr>
        <td>Lhasa Apso</td>
    </tr>
    <tr>
        <td>Doberman Pinscher-Dalmatian Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Poodle-Bernese Mountain Dog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Poodle-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Pumi</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Newfoundland</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Labrador Retriever-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Miniature Pinscher</td>
    </tr>
    <tr>
        <td>Stabyhoun</td>
    </tr>
    <tr>
        <td>Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Bullmastiff Mix</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier</td>
    </tr>
    <tr>
        <td>German Wirehaired Pointer</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Welsh Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bouvier des Flandres</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Wire Fox Terrier-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Lhasa Apso-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Poodle-Miniature Schnauzer Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Shiba Inu</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Newfoundland</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Great Pyrenees-Australian Cattle Dog Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Alaskan Malamute</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Greyhound</td>
    </tr>
    <tr>
        <td>Keeshond</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Maltese Mix</td>
    </tr>
    <tr>
        <td>Airedale Terrier</td>
    </tr>
    <tr>
        <td>Maltese-Poodle Mix</td>
    </tr>
    <tr>
        <td>Lowchen</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua-Poodle Mix</td>
    </tr>
    <tr>
        <td>Parson Russell Terrier-Poodle Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog-Great Pyrenees Mix</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Eskimo Dog</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Chihuahua-Cocker Spaniel Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Greyhound Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Miniature American Shepherd</td>
    </tr>
    <tr>
        <td>English Setter</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier-Papillon Mix</td>
    </tr>
    <tr>
        <td>Norwegian Elkhound</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>Boxer-American Staffordshire Terrier Mix</td>
    </tr>
    <tr>
        <td>West Highland White Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Poodle-Soft Coated Wheaten Terrier Mix</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Greater Swiss Mountain Dog</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Maltese</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Bloodhound Mix</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Brittany</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Beagle-Chinese Shar-Pei Mix</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Poodle-Yorkshire Terrier Mix</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-Rhodesian Ridgeback Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Border Collie Mix</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cairn Terrier</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Boxer Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Flat-Coated Retriever-Irish Water Spaniel Mix</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Beagle-Dachshund Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Portuguese Podengo</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Maltese Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Basset Hound-Australian Shepherd Mix</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Brittany-Pointer Mix</td>
    </tr>
    <tr>
        <td>Miniature American Shepherd</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog-Bearded Collie Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Bichon Frise-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Beagle-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Boxer</td>
    </tr>
    <tr>
        <td>Rhodesian Ridgeback</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Bichon Frise Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Bichon Frise-Shih Tzu Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer-Poodle Mix</td>
    </tr>
    <tr>
        <td>Chihuahua-Dachshund Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Shetland Sheepdog</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Poodle Mix</td>
    </tr>
    <tr>
        <td>Vizsla</td>
    </tr>
    <tr>
        <td>Whippet</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>Border Collie-Borzoi Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever-Brittany Mix</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Poodle Mix</td>
    </tr>
    <tr>
        <td>Poodle-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Boxer-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Great Dane Mix</td>
    </tr>
    <tr>
        <td>Border Collie-Bearded Collie Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Poodle Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Russell Terrier-Japanese Chin Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Cocker Spaniel-Pug Mix</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Russell Terrier-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Bernese Mountain Dog</td>
    </tr>
    <tr>
        <td>Soft Coated Wheaten Terrier</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bulldog-Dogo Argentino Mix</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Beagle-Bulldog Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mudi</td>
    </tr>
    <tr>
        <td>Doberman Pinscher</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Terrier</td>
    </tr>
    <tr>
        <td>Airedale Terrier</td>
    </tr>
    <tr>
        <td>Catahoula Leopard Dog</td>
    </tr>
    <tr>
        <td>Shorkie</td>
    </tr>
    <tr>
        <td>Berger Picard</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pomeranian</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Australian Cattle Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>German Shorthaired Pointer</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Weimaraner</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Golden Retriever Mix</td>
    </tr>
    <tr>
        <td>Boxer-American Pit Bull Terrier Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Rottweiler</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Chihuahua</td>
    </tr>
    <tr>
        <td>German Shepherd Dog-Rottweiler Mix</td>
    </tr>
    <tr>
        <td>American Pit Bull Terrier</td>
    </tr>
    <tr>
        <td>Chinese Crested</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Chihuahua-Boston Terrier Mix</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Havanese</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Miniature Schnauzer Mix</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>English Setter</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Pembroke Welsh Corgi</td>
    </tr>
    <tr>
        <td>Border Terrier-Beagle Mix</td>
    </tr>
    <tr>
        <td>Miniature Pinscher-Chihuahua Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Coton de Tulear</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Bichon Frise-Lhasa Apso Mix</td>
    </tr>
    <tr>
        <td>English Springer Spaniel</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Great Pyrenees-Brussels Griffon Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Welsh Terrier</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Afghan Hound</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Labrador Retriever-Boxer Mix</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Airedale Terrier</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Other</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Airedale Terrier</td>
    </tr>
    <tr>
        <td>Cockapoo</td>
    </tr>
    <tr>
        <td>Border Collie-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Portuguese Water Dog</td>
    </tr>
    <tr>
        <td>Schipperke</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Komondor</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd-Pembroke Welsh Corgi Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Border Collie-Pembroke Welsh Corgi Mix</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Italian Greyhound-Dachshund Mix</td>
    </tr>
    <tr>
        <td>German Pinscher</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Belgian Malinois</td>
    </tr>
    <tr>
        <td>English Springer Spaniel-Labrador Retriever Mix</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Field Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle-Maltese Mix</td>
    </tr>
    <tr>
        <td>Basset Hound</td>
    </tr>
    <tr>
        <td>Great Dane</td>
    </tr>
    <tr>
        <td>Staffordshire Bull Terrier</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Rat Terrier-Basenji Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Cane Corso</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>Pug</td>
    </tr>
    <tr>
        <td>German Shepherd Dog</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Akita</td>
    </tr>
    <tr>
        <td>Standard Schnauzer</td>
    </tr>
    <tr>
        <td>Russell Terrier</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Standard Schnauzer-Russell Terrier Mix</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Bulldog</td>
    </tr>
    <tr>
        <td>Boston Terrier</td>
    </tr>
    <tr>
        <td>Australian Terrier</td>
    </tr>
    <tr>
        <td>Siberian Husky</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>French Bulldog</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Dachshund</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>American Staffordshire Terrier-Mastiff Mix</td>
    </tr>
    <tr>
        <td>Golden Retriever</td>
    </tr>
    <tr>
        <td>Border Collie</td>
    </tr>
    <tr>
        <td>I Don&#x27;t Know</td>
    </tr>
    <tr>
        <td>Shih Tzu</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Australian Shepherd</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Puggle</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Poodle</td>
    </tr>
    <tr>
        <td>Beagle</td>
    </tr>
    <tr>
        <td>Rat Terrier-Basenji Mix</td>
    </tr>
    <tr>
        <td>Labrador Retriever</td>
    </tr>
    <tr>
        <td>Labradoodle</td>
    </tr>
    <tr>
        <td>Dalmatian</td>
    </tr>
    <tr>
        <td>Bichon Frise</td>
    </tr>
    <tr>
        <td>Miniature Schnauzer</td>
    </tr>
    <tr>
        <td>Cocker Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Golden Doodle</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Cavalier King Charles Spaniel</td>
    </tr>
    <tr>
        <td>Mixed</td>
    </tr>
    <tr>
        <td>Yorkshire Terrier</td>
    </tr>
    <tr>
        <td>Mixed</td>



