set -e
cd "$(dirname "$0")"
rm -f library.db library2.db
sqlite3 library.db  < setup.sql
sqlite3 library2.db < setup.sql
sqlite3 library2.db < fixture2.sql
echo "===== Core fixture ====="
sqlite3 -header -column library.db < answers.sql
echo
echo "===== Second fixture (adds Dev borrowing Poems, Eve with returned loan) ====="
sqlite3 -header -column library2.db < answers.sql
 