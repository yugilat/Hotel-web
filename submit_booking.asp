<%
' Set up the database connection
Dim conn, sql, rs
Set conn = Server.CreateObject("ADODB.Connection")
conn.Open "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\Users\Yugi\Desktop\HotelApp\webpage\database\Database1.accdb;"

' Get form data from the request
Dim checkinDate, checkoutDate, numAdults, numChildren, guestName, paymentMethod
checkinDate = Request.Form("checkinDate")
checkoutDate = Request.Form("checkoutDate")
numAdults = Request.Form("numAdults")
numChildren = Request.Form("numChildren")
guestName = Request.Form("guestName")
paymentMethod = Request.Form("paymentMethod")

' Split guest name into first and last names
Dim guestFName, guestLName
guestFName = Split(guestName, " ")(0)
guestLName = Split(guestName, " ")(1)

' Insert guest data into the Guests table
sql = "INSERT INTO Guests (Guest_FName, Guest_LName) VALUES ('" & guestFName & "', '" & guestLName & "')"
conn.Execute sql

' Get the Guest_ID of the newly inserted guest
Set rs = conn.Execute("SELECT @@IDENTITY AS GuestID")
Dim guestID
guestID = rs("GuestID")

' Insert booking data into the Bookings table
sql = "INSERT INTO Bookings (Guest_ID, Check_in_Date, Check_out_Date, Number_of_Adults, Number_of_Children) " & _
      "VALUES (" & guestID & ", #" & checkinDate & "#, #" & checkoutDate & "#, " & numAdults & ", " & numChildren & ")"
conn.Execute sql

' Get the Booking_ID of the newly inserted booking
Set rs = conn.Execute("SELECT @@IDENTITY AS BookingID")
Dim bookingID
bookingID = rs("BookingID")

' Insert transaction data into the Transactions table
sql = "INSERT INTO Transactions (Booking_ID, Payment_method) " & _
      "VALUES (" & bookingID & ", '" & paymentMethod & "')"
conn.Execute sql

' Close the connection
conn.Close
Set conn = Nothing
%>
