# Import Libraries
import pymysql
import matplotlib.pyplot as plt
import pandas as pd

def connect(name):
    '''
    :param name: Name of the Database
    :return: Connection. Connects to Database, and produces Error Message if Connection is Unsuccessful
    '''
    # Prompt User for Username and Password
    username = input("Enter username: ")
    pword = input("Enter password: ")

    # Connect to SQL
    try:
        connection = pymysql.connect(
            host="localhost",
            user=username,
            password=pword,
            database=name,
            cursorclass=pymysql.cursors.DictCursor,
            autocommit=True
        )
        return connection
    # If Database does not Connect Print Error message
    except pymysql.Error as e:
        code, msg = e.args
        print("Cannot connect to the database", code, msg)

def get_books(connection):
    '''
    :param connection: Connection to MySQLWorkbench
    :return: None. Prints Book Information that is matched with the inputted Genre
    '''
    # READ OPERATION
    cursor = connection.cursor(pymysql.cursors.DictCursor)
    cursor.execute("SELECT DISTINCT genre FROM book_details")
    result_set = cursor.fetchall()
    print("\nAll Legal Genres: ")
    for row in result_set:
        print("%s" % (row["genre"]))

    while True:
        # Prompt User for Genre
        user_genre = str(input("\nEnter a Genre as listed above: "))

        if {"genre": user_genre} in result_set:
            break
        else:
            # Generate an error message to standard output and re-prompt the user for input, if invalid input.
            print("Invalid, please enter a genre from the above list")

    #Use the genre as an arguement to the genre_search(genre_name). Call the procedure.
    try:
        cursor.callproc("genre_search", [user_genre])

        # Print the result set of genre_search() to standard output.
        print("\nAll results for the inputted genre: ")
        for result in cursor.fetchall():
            print(result)

    # Generate an Error Message
    except Exception as e:
        print("Exeception occured:{}".format(e))

def update_phone_num(connection):
    '''
    :param connection: Connection to MySQLWorkbench
    :return: None. Prints updated Phone Number for inputted Phone Number and Name
    '''
    cursor = connection.cursor()
    cursor.execute('SELECT patron_name FROM patron')
    result_set = cursor.fetchall()
    print("\nAll Legal Patrons: ")
    for row in result_set:
        print("%s" % (row["patron_name"]))

    while True:
        # Prompt User for Patron Name
        lib_patron = str(input("\nChoose a Patron Name from the List above: "))
        user_phone = int(input("Enter a new 10 digit phone number you would like to update with: "))

        if {"patron_name": lib_patron} in result_set and len(str(user_phone)) <= 10:
            break
        else:
            # Generate an error message to standard output and re-prompt the user for input, if invalid input.
            print("Invalid patron name or phone number, please follow the instructions again.")

        # Use the patron_name as an arguement to the updphone(p_name, patronphoneNumber). Call the procedure.
    try:
        cursor.callproc("updphone", [lib_patron, user_phone])

        # Print the result set of updphone() to standard output.
        print("\nUpdated Phone Number for the Patron: ")
        for result in cursor.fetchall():
            print(result)

     # Generate an Error Message
    except Exception as e:
        print("Exeception occured:{}".format(e))

def deleteaccount(connection):
    '''
    :param connection: Connection to MySQLWorkbench
    :return: None. Deletes the Patron's Account from the Database
    '''
    cursor = connection.cursor()
    cursor.execute("SELECT patronId, patron_name, account.account_num FROM patron LEFT JOIN account on patron.patronId = account.pat_id")
    result_set = cursor.fetchall()
    print(result_set)
    print("\nAccount Information for All Patrons in the order (name, account number, patron id): ")
    for row in result_set:
        print("%s, %s, %s" % (row["patron_name"], row["account_num"], row["patronId"]))

    while True:
        # Prompt User for Name, Account number, and Patron Id
        patron_name = str(input("\nEnter Patron's Name from above List: "))
        patron_account = int(input("Enter Patron's Account Number from above List: "))
        id_num = int(input("Enter Patron's ID from above List: "))

        if {"patronId": id_num, 'patron_name': patron_name, "account_num": patron_account} in result_set:
            break
        else:
            # Generate an error message to standard output and re-prompt the user for input, if invalid input.
            print("Invalid, please enter account information from the above list")

        # Use the patron_name as an arguement to the delaccount(acc_num) Procedure. Call the procedure.
    try:
        cursor.callproc("delaccount", [patron_account])

        # Account Deleted Statement
        print("\nAccount successfully deleted ")

     # Generate an Error Message
    except Exception as e:
        print("Exeception occured:{}".format(e))

def deleteLibrarian(connection):
    '''
    :param connection: Connection to MySQLWorkbench
    :return: None. Deletes a Librarian from the Database
    '''
    cursor = connection.cursor()
    cursor.execute("SELECT librarian_name FROM librarian")

    result_set = cursor.fetchall()
    print("\nAll Legal Librarian Names: ")
    for row in result_set:
        print("%s" % (row["librarian_name"]))

    while True:
        # Prompt User for Librarian Name
        user_librarian = str(input("\nChoose a Librarian Name from the List above: "))

        if {"librarian_name": user_librarian} in result_set:
            break
        else:
            # Generate an error message to standard output and re-prompt the user for input, if invalid input.
            print("Invalid librarian name, please follow the instructions again.")

    # # Use the user_librarian_name as an arguement to the delLibrarian(librarian_name). Call Procedure
    try:
        cursor.callproc("delLibrarian", [user_librarian])

        # Librarian Deleted Statement
        print("\nLibrarian successfully deleted ")

     # Generate an Error Message
    except Exception as e:
        print("Exeception occured:{}".format(e))


def create_book(connection):
    '''
    :param connection: Connection to MySQLWorkbench
    :return: None. Adds a new tuple to the book table and the associated tables
    '''
    cursor = connection.cursor()

    # Getting user inputs and checking for errors
    while True:
        isbn_book = input("Please Enter an ISBN that is within 13 Characters: ")
        user_barcode = input("Please Enter the Book's Barcode within 13 Characters: ")
        user_title = input("Enter the Title of the Book: ")
        user_author = input("Enter the Author Name of the Book: ")
        library_id = input("Enter the Library Id of where this book is located: ")

        if len(isbn_book) <= 13:
            break
        else:
            print("The isbn is invalid. Please enter an isbn with at most 13 characters")

        if len(user_barcode) <= 13:
            break
        else:
            print("The barcode is invalid. Please enter a barcode with at most 13 characters")

    # Calling the procedure
    try:
        cursor.callproc("createBook", [isbn_book, user_barcode, user_title, user_author, library_id])
        print("Book successfully added")

    # Generate an Error Message
    except Exception as e:
        print("Exeception occured:{}".format(e))

def genre_vis(connection):
    '''
    :param connection: Connection to MySQLWorkbench
    :return: None. Bar Chart of the Number of Books for each Genre in the Database
    '''
    c1 = connection.cursor()
    c1.execute("SELECT DISTINCT genre FROM book_details GROUP BY genre ")
    c2 = connection.cursor()
    c2.execute("SELECT COUNT(genre) as count FROM book_details GROUP BY genre ")

    # Create a List of the Genres
    genres = []
    for row in c1.fetchall():
        genres.append(str(row['genre']))
    print(genres)

    # Create a list of the corresponding genre counts
    genre_count = []
    for row in c2.fetchall():
        genre_count.append(row['count'])
    print(genre_count)

    # Convert Lists to Dataframe
    df = pd.DataFrame(list(zip(genres, genre_count)), columns=['genres', 'count'])
    df = df.sort_values(by=["count"], ascending=False)

    # Plot Bar Chart
    plt.figure(figsize=(12, 15))
    plt.bar(df["genres"], df["count"])
    plt.xticks(rotation=45)
    plt.xlabel("Genre")
    plt.ylabel("Genre Count")
    plt.title("Number of Books per Genre")
    plt.show()

def pieplot_vis(connection):
    '''
    :param connection: Connection to MySQLWorkbench
    :return:  None. Pie Chart of Publishers in Database
    '''
    c1 = connection.cursor()
    c1.execute("SELECT DISTINCT publisher FROM book_details GROUP BY publisher")
    c2 = connection.cursor()
    c2.execute("SELECT count(publisher) AS count FROM book_details GROUP BY publisher")

    publishers = []
    for row in c1.fetchall():
        publishers.append(str(row['publisher']))
    print(publishers)

    publisher_count = []
    for row in c2.fetchall():
        publisher_count.append(row['count'])
    print(publisher_count)

    # Plot Figure
    fig = plt.figure(figsize=(10, 7))
    plt.pie(publisher_count, labels=publishers)
    plt.title("Portion of Books Published by each Publisher")
    plt.show()

def line_chart(connection):
    c1 = connection.cursor()
    c1.execute("SELECT loanPeriod FROM book_details")
    c2 = connection.cursor()
    c2.execute("SELECT numCopies FROM book_details")

    loan_lst = []
    for row in c1.fetchall():
        loan_lst.append(row['loanPeriod'])
    print(loan_lst)

    copy_numbers = []
    for row in c2.fetchall():
        copy_numbers.append(row['numCopies'])
    print(copy_numbers)

    # Plot Figure
    fig = plt.figure(figsize=(10, 7))
    plt.scatter(copy_numbers, loan_lst)
    plt.title("Loan Period vs Number of Copies of a particular Book")
    plt.xlabel("Number of Copies per Book")
    plt.ylabel("Loan Period per Book")
    plt.show()


if __name__ == '__main__':
    connection = connect('minilib_db')
    get_books(connection)
    update_phone_num(connection)
    deleteaccount(connection)
    deleteLibrarian(connection)
    create_book(connection)
    genre_vis(connection)
    pieplot_vis(connection)
    line_chart(connection)

    # Close Connection
    connection.close()
    print("\nConnection closed")


