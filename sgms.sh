#! /usr/bin/bash

shopt -s extglob

std_data_dir="sgms_data/students/"

mkdir -p "$std_data_dir"


ManageStudents() {
    while true
     do
        echo ""
        echo "*** ManageStudents ***"

        select choice in \
		"▸AddStudent" \
		"▸ListStudents"\
		"▸UpdateStudent"\
		"▸DeleteStudent" \
		"▸Exit"
        do
            case $REPLY in
                1) AddStudent ;;
                2) ListStudents ;;
                3) UpdateStudent ;;
                4) DeleteStudent ;;
                5) mainmenu ;;
                *)
                    echo "Invalid option"
                    ;;
            esac
            break
        done
    done
}

mainmenu(){
while true; do
    echo ""
    echo " ---- Bash SGMS ----"

	select choice in \
		"▸ManageStudents" \
		"▸ManageSubjects" \
		"▸ManageGrades" \
		"▸Reports&Statistics" \
		"▸Exit"
	do
		case $REPLY in 
	1)  	 ManageStudents ;;
	2)	 ManageSubjects ;;
	3) 	 ManageGrades ;;
	4)	 Reports_Statistics ;;
	5)	 exit ;;
		
	*)
		echo "Invalid option"
	esac
			
 	break
	done

done
}
mainmenu
