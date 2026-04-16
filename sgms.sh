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
	3) 	 grade_menu ;;
	4)	 Reports_Statistics ;;
	5)	 exit ;;
		
	*)
		echo "Invalid option"
	esac
			
 	break
	done

done
}

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
# ------------------ grade part ( omar )

grade_menu(){


		student_dir="sgms_data/students"
		subject_dir="sgms_data/subjects"
		grade_dir="sgms_data/grades"

	mkdir -p "$student_dir" "$subject_dir" "$grade_dir"
	while true
	do
		echo "----- grade management -----"
		echo "1) assign grade to student"
		echo "2) update existing grade"
		echo "3) delete a grade"
		echo "4) view grades by subject"
		echo "5) view grades by student"
		echo "6) back"
		read -p "choose: " choice

		case $choice in
			1) assign_grade ;;
			2) update_grade ;;
			3) delete_grade ;;
			4) view_by_subject ;;
			5) view_by_student ;;
			6) break ;;
			*) echo "invalid choice" ;;
		esac
	done
}

assign_grade(){

	# -------------- subject code
	while true
	do
		read -p "subject code: " code
		case $code in
			+([A-Za-z])+([0-9]))
				letters=$(echo "$code" | sed 's/[0-9]*$//')
				digits=$(echo "$code"  | sed 's/^[A-Za-z]*//')

				if [[ ${#letters} -ge 2 && ${#letters} -le 5 && ${#digits} -ge 2 && ${#digits} -le 4 ]]
				then
					if [[ -f "$subject_dir/$code.sub" ]]
					then
						break
					else
						echo "subject not found."
					fi
				else
					echo "invalid code."
				fi
				;;
			*) echo "invalid code." ;;
		esac
	done

	# --------------------- student id
	while true
	do
		read -p "student id: " sid
		case $sid in
			+([1-9])*([0-9]))
				if [[ ${#sid} -le 10 ]]
				then
					if [[ -f "$student_dir/$sid.stu" ]]
					then
						break
					else
						echo "student not found."
					fi
				else
					echo "invalid id."
				fi
				;;
			*) echo "invalid id." ;;
		esac
	done

	file="$grade_dir/$code.grd"

	# prevent duplicate grade


	if [[ -f "$file" ]] && grep -q "^$sid|" "$file" 2>/dev/null
	then
		echo " grade already exists"
		return
	fi


	# ------------ score

	while true
	do
		read -p "score (0-100): " score
		case $score in
			+([0-9])|+([0-9]).+([0-9]))
				if echo "$score" | awk '{ if($1>=0 && $1<=100) exit 0; else exit 1 }'
				then
					break
				else
					echo "invalid score."
				fi
				;;
			*) echo "invalid score." ;;
		esac
	done

	# ----- letter

	letter=$(echo "$score" | awk '{
		s=$1
		if      (s>=90) print "A+"
		else if (s>=85) print "A"
		else if (s>=80) print "A-"
		else if (s>=75) print "B+"
		else if (s>=70) print "B"
		else if (s>=65) print "B-"
		else if (s>=60) print "C+"
		else if (s>=55) print "C"
		else if (s>=50) print "C-"
		else if (s>=45) print "D"
		else            print "F"
	}')

	echo "$sid|$score|$letter" >> "$file"
	echo "assigned: $sid -> $code ($score $letter)"
}
#--------------------------------------------------------------------------------------------- update function 


update_grade(){

# ---------------- subject code

	while true
	do
		read -p "subject code: " code
		case $code in
			+([A-Za-z])+([0-9]))
				letters=$(echo "$code" | sed 's/[0-9]*$//')
				digits=$(echo "$code"  | sed 's/^[A-Za-z]*//')

				if [[ ${#letters} -ge 2 && ${#letters} -le 5 && ${#digits} -ge 2 && ${#digits} -le 4 ]]
				then
					if [[ ! -f "$subject_dir/$code.sub" ]]
					then
						echo "subject not found."
						continue
					fi

					if [[ ! -f "$grade_dir/$code.grd" ]]
					then
						echo "no grades for this subject"
						continue
					fi

					break
				else
					echo "invalid code"
				fi
				;;
			*) echo "invalid code" ;;
		esac
	done

# ------------------ student id


	while true
	do
		read -p "student id: " sid
		case $sid in
			+([1-9])*([0-9]))
				if [[ ${#sid} -le 10 ]]
				then
					break
				else
					echo "invalid id"
				fi
				;;
			*) echo "invalid id" ;;
		esac
	done

	file="$grade_dir/$code.grd"
	if ! grep -q "^$sid|" "$file"
	then
		echo "grade not found"
		return
	fi

	# ------------ new score
	while true
	do
		read -p "new score (0-100): " score
		case $score in
			+([0-9])|+([0-9]).+([0-9]))
				if echo "$score" | awk '{ if($1>=0 && $1<=100) exit 0; else exit 1 }'
				then
					break
				else
					echo "invalid score"
				fi
				;;
			*) echo "invalid score" ;;
		esac
	done

	# ---------------- new letter 
	letter=$(echo "$score" | awk '{
		s=$1
		if      (s>=90) print "A+"
		else if (s>=85) print "A"
		else if (s>=80) print "A-"
		else if (s>=75) print "B+"
		else if (s>=70) print "B"
		else if (s>=65) print "B-"
		else if (s>=60) print "C+"
		else if (s>=55) print "C"
		else if (s>=50) print "C-"
		else if (s>=45) print "D"
		else            print "F"
	}')

	sed -i "s/^$sid|.*/$sid|$score|$letter/" "$file"
	echo "updated: $sid -> $code ($score $letter)"
}

delete_grade(){

# ------------------- subject code
	while true
	do

		read -p "subject code: " code
		case $code in
			+([A-Za-z])+([0-9]))
				letters=$(echo "$code" | sed 's/[0-9]*$//')
				digits=$(echo "$code"  | sed 's/^[A-Za-z]*//')

				if [[ ${#letters} -ge 2 && ${#letters} -le 5 && ${#digits} -ge 2 && ${#digits} -le 4 ]]
				then
					if [[ ! -f "$subject_dir/$code.sub" ]]
					then
						echo "subject not found."
						continue
					fi
					break
				else
					echo "invalid code."
				fi
				;;
			*) echo "invalid code." ;;
		esac
	done


	file="$grade_dir/$code.grd"
	if [[ ! -f "$file" ]]
	then
		echo "no grades for this subject."
		return
	fi



	# -------- student id --------
	while true
	do
		read -p "student id: " sid
		case $sid in
			+([1-9])*([0-9]))
				if [[ ${#sid} -le 10 ]]
				then
					break
				else
					echo "invalid id."
				fi
				;;
			*) echo "invalid id." ;;
		esac
	done

	if ! grep -q "^$sid|" "$file"
	then
		echo "grade not found."
		return
	fi

	read -p "sure? (y/n): " ans
	if [[ $ans == "y" || $ans == "Y" ]]
	then
		sed -i "/^$sid|/d" "$file"
		echo "deleted."
	else
		echo "canceled."
	fi
}

view_by_subject(){

	# ------------------------ subject code
	while true
	do
		read -p "subject code: " code
		case $code in
			+([A-Za-z])+([0-9]))
				letters=$(echo "$code" | sed 's/[0-9]*$//')
				digits=$(echo "$code"  | sed 's/^[A-Za-z]*//')

				if [[ ${#letters} -ge 2 && ${#letters} -le 5 && ${#digits} -ge 2 && ${#digits} -le 4 ]]
				then
					if [[ ! -f "$subject_dir/$code.sub" ]]
					then
						echo "subject not found"
						continue
					fi
					break
				else
					echo "invalid code"
				fi
				;;
			*) echo "invalid code" ;;
		esac
	done

	file="$grade_dir/$code.grd"
	if [[ ! -f "$file" ]] || [[ ! -s "$file" ]]
	then
		echo "no grades"
		return
	fi

	echo "student_id | score | letter"
	echo "-----------------------------"
	awk -F"|" '{print $1" | "$2" | "$3}' "$file"
}




mainmenu