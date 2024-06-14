#!/bin/bash

LIBRARY_FILE="library_data.txt"

display_menu() {
  clear
  echo "Library Management System"
  echo "1. Add New Book"
  echo "2. Update Book Information"
  echo "3. Remove Book"
  echo "4. Search Book"
  echo "5. List All Books"
  echo "6. Exit"
}

add_book() {
  read -p "Enter Book Title: " title
  read -p "Enter Author: " author
  read -p "Enter ISBN: " isbn

  # Check for empty input
  if [[ -z $title || -z $author || -z $isbn ]]; then
    echo "Error: Please provide all required information."
  else
    echo "$title|$author|$isbn" >> "$LIBRARY_FILE"
    echo "Book added successfully."
  fi
}

# Function to update book information
update_book() {
  read -p "Enter Book Title or ISBN to Update: " query
  grep -q -i "$query" "$LIBRARY_FILE"
  if [ $? -eq 0 ]; then
    read -p "Enter New Author: " new_author
    read -p "Enter New ISBN: " new_isbn
    sed -i "s/.*$query.*/$query|$new_author|$new_isbn/" "$LIBRARY_FILE"
    echo "Book information updated successfully."
  else
    echo "Book not found."
  fi
}

# Function to remove a book
remove_book() {
  read -p "Enter Book Title or ISBN to Remove: " query
  grep -q -i "$query" "$LIBRARY_FILE"
  if [ $? -eq 0 ]; then
    sed -i "/$query/d" "$LIBRARY_FILE"
    echo "Book removed successfully."
  else
    echo "Book not found."
  fi
}

# Function to search for a book
search_book() {
  read -p "Enter Search Query (Title, Author, or ISBN): " query
  if [ -s "$LIBRARY_FILE" ]; then
    grep -i "$query" "$LIBRARY_FILE"
  else
    echo "Library is empty or does not exist."
  fi
}

# Function to list all books
list_books() {
  if [ -s "$LIBRARY_FILE" ]; then
    cat "$LIBRARY_FILE"
  else
    echo "Library is empty or does not exist."
  fi
}

# Main loop
while true; do
  display_menu
  read -p "Enter your choice: " choice

  case $choice in
    1) add_book ;;
    2) update_book ;;
    3) remove_book ;;
    4) search_book ;;
    5) list_books ;;
    6)
      echo "Exiting..."
      exit 0
      ;;
    *)
      echo "Invalid choice. Please enter a valid option."
      ;;
  esac

  read -p "Press Enter to continue..."
done
