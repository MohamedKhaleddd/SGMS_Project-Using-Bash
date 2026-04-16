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
	                        
                done
                echo "$std_id" >> "$file"
                echo "$std_name" >> "$file"
                echo "$std_Email" >> "$file"
                echo "$std_year" >> "$file"
                echo "Student Added"
            
                read -p "Do u wanna add more student?(y/n) " check
                if [[ "$check" == "y" || "$check" == "Y" ]]
                        then 
                                continue
                                
                else 
                        break
                        
                fi
        done

}
function ListStudents(){

        if [[ ! -d "$std_data_dir" || -z "$(ls "$std_data_dir")" ]]; then
                echo "not founded any students"
                return
        fi

        for file in "$std_data_dir"/*.stu
                do
                        echo "----------------------"
                        cat "$file"
                done

}

function check_name(){
		    
		    while true
		                do
			                read -p "Enter new name: " name
			                if [[ -z "$name" ]]
			                        then
			                                echo "name cant be empty"
			                else
			                sed -i "2s/.*/$name/" "$file"
			                        break
			                fi
		                done
		    
}

function check_email (){

                while true;
		        do 
			    read -p "Enter new email: " email
			if [[ "$email" =~  ^.+@.+\..+$ ]]
			        then
			                sed -i "3s/.*/$email/" "$file"
			                break 
			else
			        echo "please input valid email"
			fi
		        done
}

function check_year(){
		while true; 
		do
			read -p "Enter new year: " year
			        if [[ "$year" =~ ^[1-6]$  ]]
			                then
			                        sed -i "4s/.*/$year/" "$file"
			                break
			        else
			                echo "please input valid number between 1-6 "
			        fi
		done

}

function UpdateStudent(){
                while true;
                        do
                                read -p "enter id student you want update: " std_id 

                                file=""$std_data_dir"/$std_id.stu"


                                if [[ ! -f "$file" ]]; then
                                        echo "student not found"
                                        continue
                                fi

                while true
                        do
      
                        echo "What do you want to update?"
  
                        select choice in "name" "email" "year" "exit"
                        do
                                case $choice in
                                "name")  
			                check_name
		                                ;;
                                "email") 
                    	                check_email
                                                ;;
                                "year") 
                  	                check_year
           		                        ;;
                                "exit") return 
                                        ;;
                                *) 
                                        echo "Invalid choice" ;;
                                esac
                                echo "Updated successfully"
                        done
    
    done
    	
    
done

}

function DeleteStudent(){
        while true; 
                do

                        if [[ ! -d "$std_data_dir" || -z "$(ls "$std_data_dir")" ]]
                        then
                                echo "no students to deleted"
                                break
                        fi

                read -p "Enter Student Id you want to delete: " std_id 
                file=""$std_data_dir"/$std_id.stu"
                if [[ ! -f "$file" ]] ; then
                        echo "student not found"
                        continue
                fi

                read -p "are you sure to delete? (y/n): " sure
                if [[ "$sure" == "y" || "$sure" == "Y" ]]; then 
                        rm "$file"
                        echo "student is deleted "
 
                else 
                        echo "cancel"
                        continue
                fi
 
                read -p "do you want delete student else? (y/n) " check
                        if [[ "$check" == "y" || "$check" == "Y" ]]; then
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
	2)	 subject_menu ;;
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
#---------------------------------------------------------- subject part ( omar )


subject_dir="sgms_data/subjects"
grade_dir="sgms_data/grades"

subject_menu(){
	      mkdir -p "$subject_dir" "$grade_dir"
	 while true
	do
		echo "----- subject management -----"
		echo "1) add subject"
		echo "2) list subjects"
		echo "3) update subject"
		echo "4) delete subject"
		echo "5) back"
		read -p "choose: " choice

		case $choice in
			1) add_subject ;;
			2) list_subjects ;;
			3) update_subject ;;
			4) delete_subject ;;
			5) break ;;
			*) echo "invalid choice." ;;
		esac
	done
}
# ----------------------

add_subject(){

	while true
	 do

		read -p "subject code : " code
		if [[ ! $code =~ ^[A-Za-z]{2,5}[0-9]{2,4}$ ]]
		then
			echo "invalid code."
			continue
		fi

		if [[ -f "$subject_dir/$code.sub" ]]
		then
			echo "already exists."
			continue
		fi
	   break
	done


	
       while true
        do
          read -p "subject name: " name

         if [[ -z $name ]]
          then
        echo "name can't be empty."
        continue
           fi

         if [[ ! $name =~ ^[A-Za-z]+([[:space:]][A-Za-z]+)*$ ]]
          then
        echo "invalid name (letters only)."
        continue
         fi

         break
        done
        
        
	while true
	do
		read -p "credits (1-6): " credits
		if [[ ! $credits =~ ^[0-9]+$ ]] || [[ $credits -lt 1 || $credits -gt 6 ]]
		then
			echo "invalid credits."
			continue
		fi
		break
	done


	echo "$code"    >  "$subject_dir/$code.sub"
	echo "$name"    >> "$subject_dir/$code.sub"
	echo "$credits" >> "$subject_dir/$code.sub"
	echo "added: $code"
}
#--------------------------


list_subjects(){


	files=$(ls "$subject_dir"/*.sub 2>/dev/null)

	if [[ -z $files ]]
	then
        	echo "no subjects."
        	return
	fi

	echo "code | name | credits"

	echo "---------------------"
	for file in $files
	do

		code=$(sed -n '1p' "$file")

		name=$(sed -n '2p' "$file")

		credits=$(sed -n '3p' "$file")

		echo "$code | $name | $credits"

	done

}

#------------------------------

update_subject(){


	while true
	do
		read -p "enter code to update: " code

		if [[ ! $code =~ ^[A-Za-z]{2,5}[0-9]{2,4}$ ]]
		then
			echo "invalid code"
			continue
		fi

		file="$subject_dir/$code.sub"
		if [[ ! -f "$file" ]]
		then
			echo "not found"
			continue
		fi

		break
	done

	old_name=$(sed -n '2p' "$file")
	old_credits=$(sed -n '3p' "$file")

	echo "current name   : $old_name"
	echo "current credits: $old_credits"
	echo "leave empty to keep old value."

	read -p "new name: " new_name
	if [[ -z $new_name ]]; 
        then 
        new_name="$old_name"; 
        fi

	while true
	do
		read -p "new credits (1-6): " new_credits
		if [[ -z $new_credits ]]
		then
		new_credits="$old_credits"
		break
		fi

		if [[ $new_credits =~ ^[0-9]+$ ]] && [[ $new_credits -ge 1 && $new_credits -le 6 ]]
		then
			break
		else
			echo "invalid credits"
		fi
	done

	echo "$code"        >  "$file"
	echo "$new_name"    >> "$file"
	echo "$new_credits" >> "$file"

	echo "updated: $code"
}

delete_subject(){


	while true
	do
		read -p "enter code to delete: " code

		if [[ ! $code =~ ^[A-Za-z]{2,5}[0-9]{2,4}$ ]]
		then
			echo "invalid code"
			continue
		fi

		file="$subject_dir/$code.sub"
		if [[ ! -f "$file" ]]
		then
			echo "not found"
			continue
		fi

		break
	done

	read -p "are you sure? (y/n): " ans
	if [[ $ans == "y" ]]
	then
		rm -f "$file"
		rm -f "$grade_dir/$code.grd" 2>/dev/null
		echo "deleted: $code"
	else
		echo "canceled."
	fi
}
