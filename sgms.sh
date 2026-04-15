#! /usr/bin/bash

shopt -s extglob

std_data_dir="sgms_data/students/"

mkdir -p "$std_data_dir"

AddStudent() {
while true
        do
        while true
                do
                        read -p "Enter your student id: " std_id
	                case $std_id in
     	                +([1-9])*([0-9]))
     	                        break 
     	                        ;;
     	 	                
                        *) 
                                echo "Error: Must enter digits  only and started from 1."; 
                        continue
                                ;;
                        esac
                done
        file="$std_data_dir/$std_id.stu"
        if [[ -f "$file" ]]
    	        then
                	echo "Error: Student with ID '$std_id' already exists."
                	continue
         fi
                
        
        while true
                do
	                read -p "Enter Your Student Name: " std_name
	                case $std_name in 
		                +([A-Za-z\ ]))
		                   break 
     	                                ;;
		                        
		                *) echo "Error: Must start Letters only."
		                        continue
		                        ;;
                        esac
                done
                
                
    while true
                do
	                read -p "Enter Your Student Email: " std_Email
	                case $std_Email in 
		                +([A-Za-z0-9._-])@+([A-Za-z]).+([A-Za-z])) 
                                  break 
     	                        ;;
		                *) echo "Error: Must Start with letter then @ mail . Domain letters only."
		                        continue
		                        ;;
                        esac
                done
                
                
        while true
                do
                        read -p "Enter your student year: " std_year
                        case $std_year in
                                +([1-6]))
                                break 
     	                        ;;
                                *) echo "Error: Must enter digits  from 1 to 6."
                                        continue
                                                ;;
	                esac
	                        echo "$std_name:$std_Email:$std_year" > "$std_data_dir/$std_id.stu"
	                        echo "Student Adeed"
                done
                echo "$std_id" >> "$file"
                echo "$std_name" >> "$file"
                echo "$std_Email" >> "$file"
                echo "$std_year" >> "$file"
                
                read -p "Do u wanna add more student?(y/n) " check
                if [[ "$check" == "y" || "$check" == "Y" ]]
                        then 
                                continue
                                
                else 
                        break
                        
                fi
        done

}


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
