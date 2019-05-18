# Novelist-VBS-Bat
Queries the EBSCOHost NovelList database using windows batch scripting and VBS via an HTTP GET request. Incorporates http-ping.exe, a free utility by CoreTechnologies: https://www.coretechnologies.com/products/http-ping/

I created this small batch utility to help automate one of my work tasks at my current job at the Berkeley Public Library, which involves pulling records from an online database (Novelist by EBSCOhost) of authors and book titles. It pulls "appeal terms" related to that author from the database and outputs them to a text file. From there, the user can use the included Python script to find which appeal terms are most common among the authors/titles pulled. It can also search Novelist for appeal terms and pull titles of books in the same manner.
