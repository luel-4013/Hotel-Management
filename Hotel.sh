#!/bin/bash
clear

register_login()
{
    echo "####################### Register admin #######################s"
    read -p "Enter username name: " nun
    read  -sp "Enter password name: " nps ##remove s on windows
    
    echo "Username: $nun Password: $nps" >> users.info
    echo "$nun#$nps" >> login.info
    echo "\cUser added succesfully"
    menu
}
register-user()
{
    echo "####################### User Registration #######################ss"
    read -p "Enter first name: " fn
    read -p "Enter second name: " sn 
    read -p "Phone number: " ph
    read -p "Reservation day(dd/mm/yy format): " rd
    read -p "Reservation class(normal,vip,premium vip): " rc
    read -p "Payment type(creditcard,cash): " py
    echo "####### Leave blank if payment is other than creditcard #######"
    read -p "Creditcard information:(number): " cri
    read -p "Creditcard information:(expire date dd/mm/yy): " crexd
    read -p "Creditcard security number(3 digits): " crsn
    
    touch users/$fn.info
    echo "First name: $fn" >> users/$fn.info
    echo "Second name: $sn" >> users/$fn.info
    echo "Phone number: $ph" >> users/$fn.info
    echo "Reservation day: $rd" >> users/$fn.info
    echo "Reservation class: $rc" >> users/$fn.info
    echo "Payment type: $py" >> users/$fn.info
    echo "Creditcard information:(number): $cri" >> users/$fn.info
    echo "Creditcard information:(expire date dd/mm/yy): $crexd" >> users/$fn.info
    echo "Creditcard security number(3 digits): $crsn" >> users/$fn.info
    echo " " >> users/$fn.info
    echo "####################### New User #######################" >> register.info
    echo "First name: $fn" >> register.info
    echo "Second name: $sn" >> register.info
    echo "Phone number: $ph" >> register.info
    echo "Reservation day: $rd" >> register.info
    echo "Reservation class: $rc" >> register.info
    echo "Payment type: $py" >> register.info
    echo "Creditcard information:(number): $cri" >> register.info
    echo "Creditcard information:(expire date dd/mm/yy): $crexd" >> register.info
    echo "Creditcard security number(3 digits): $crsn" >> register.info
    echo " " >> register.info
    echo "Data registered succesfully:"
    menu
}
display_account_info()
{
    echo "########################## Account Info ##########################"
    echo "The users are: "
    ls users/
    echo ""
        echo ""  
        echo ""  
    read -p "Enter usernamme with to display more information or type e to close: " dai
    if [[ $dai == e ]]
    then
            menu
    else
        echo ""
        echo ""
            cat users/$dai.info
            echo ""
        echo ""

    fi
    menu #might screwup things
}
display_admin_info()
{
        echo ""
        echo ""
    LINE=1
    while read -r CURRENT_LINE
        do
            echo "$LINE: $CURRENT_LINE"
            ((LINE++))
    done < "./login.info"
    echo ""
        echo ""

    menu #might screwup things
}
generate_pass()
{
    echo "####################### Password generation #######################"
    echo "Can't think a password by yourself?"
    echo "Don't worry we will help you!"
    read -p  "Just enter your password length: " pl
    echo "Generating password..."
    for p in $(seq 1 3);
    do
        openssl rand -base64 48 | cut -c1-$pl
    done
    echo "Above there are 3 random passwords generated for you to select from"
}
delete()
{
      read -p  "Enter the customers name : " dcn
      rm $dcn
      echo "Data successfully deleted!!!4" 
}
 update()
 {
         echo "####################### User Update #######################ss"
    read -p "Enter name of the user to update: " ntm
        ls users/
        rm users/$ntm.info
    read -p "Enter first name: " fn
    read -p "Enter second name: " sn 
    read -p "Phone number: " ph
    read -p "Reservation day(dd/mm/yy format): " rd
    read -p "Reservation class(normal,vip,premium vip): " rc
    read -p "Payment type(creditcard,cash): " py
    echo "####### Leave blank if payment is other than creditcard #######"
    read -p "Creditcard information:(number): " cri
    read -p "Creditcard information:(expire date dd/mm/yy): " crexd
    read -p "Creditcard security number(3 digits): " crsn
    
    touch users/$fn.info
    echo "First name: $fn" >> users/$fn.info
    echo "Second name: $sn" >> users/$fn.info
    echo "Phone number: $ph" >> users/$fn.info
    echo "Reservation day: $rd" >> users/$fn.info
    echo "Reservation class: $rc" >> users/$fn.info
    echo "Payment type: $py" >> users/$fn.info
    echo "Creditcard information:(number): $cri" >> users/$fn.info
    echo "Creditcard information:(expire date dd/mm/yy): $crexd" >> users/$fn.info
    echo "Creditcard security number(3 digits): $crsn" >> users/$fn.info
    echo " " >> users/$fn.info
 }
# reserve()
# {}
# avail_room()
# {}
menu()
{
    echo "######################## Welcome boss!! ########################"
    echo "1.Register admin"
    echo "2.Display admin info"
    echo "3.Register user"
    echo "4.Display user info"
    echo "5.Make reservation"
    echo "6.Delete || Cancel reservation"
    echo "7.Update reservation"
    #echo "8.Available rooms"
    echo "9.Simple adminsitrative"
    read -p "Enter your choice: " dmenu

    case $dmenu in
        '1' )
                register_login
                menu ;;
        '2' )
                display_admin_info
                menu ;;
        '3' )
                register-user
                menu ;;
        '4' )
                display_account_info
                menu ;;  
        '5' )
                register-user
                 #make-reservation
                menu ;;##alternative option top
        '6' )
                delete
                menu ;;
        '7' )
                update
                menu ;;
        '8' )
                echo "This feature will be enabled in the next version"
                menu ;;
        '9' )
                sys-admin ;;
                #menu ;;
         *  )
                echo "Invalid input please read instructions carefully!!"
                sys-admin ;;
        #    *)
        #         echo "Invalid input please read instructions carefully!!"
        #         sys-admin ;;
    esac

}
test-login()
{
    read -p "Enter username: " usrn </dev/tty
    read -sp "Enter password: " pssw </dev/tty  #remove s on wind


    counter=0
    while IFS='#' read -r USERNAME PASSWORD
    do
        if [ "$usrn == $USERNAME" ] && [ "$pssw == $PASSWORD" ];
        then
            ((counter ++))
        fi
    done <login.info

    if [ "$counter" -gt "0" ]
    then
            menu   
    else
         test-login
    fi
}
sys-admin()
{
    echo "################################## Simple administrative whatever... ##################################"
    echo "1.Display disk usage"
    echo "2.Display folder size"
    echo "3.Kill process"
    echo "4.Kill stuck process"
    echo "5.List all process"
    echo "6.Update system"
    echo "7.Upgrade system"
    echo "8.Dist-upgrade"
    echo "8.Display Open ports"
    echo "9.Search file"
    echo "10.Operating system details"
    echo "11.Logged in users info"
    echo "12.Number of files in a directory"
    echo "13.Generate password"
    echo "14.Main menu"
    read -p "Enter your choice: " chs

    case $chs in
        '1' )
                df -ah
                #register_login
                sys-admin ;;
        '2' )
                read -p "Enter folder name for path to folder: " foln
                du -sh $foln
                sys-admin ;;
        '3' )
                read -p "Enter process id: " proc_id
                Kill $proc_id
                sys-admin ;;
        '4' )
                read -p "Enter application name: " proc_nm
                killall $proc_nm 
                sys-admin ;;  
        '5' )
                ps
                sys-admin ;;##alternative option top
        '6' )
                apt-get update
                sys-admin ;;
        '7' )
                apt-get dist-upgrade
                sys-admin ;;
        '8' )
                netstat -tulpn ;;
        '9' )
                read -p "Enter file name to search: " mis_file
                locate $mis_file
                sys-admin ;;
        '10' )
                uname -a
                sys-admin;;
         '11' )
                echo "Currently Logged in users: " 
                who -q
                sys-admin ;;
         '12' )
                echo "Number of files in the dir are"
                ls | wc -l
                sys-admin ;;
         '13' )
                generate_pass
                sys-admin ;;
         '14' )
                menu ;;
            *)
                echo "Invalid input please read instructions carefully!!"
                sys-admin ;;
    esac

}
echo "######################### Hotel Management System #########################"
#login
#register-user
#generate_pass
# register_login
# menu


test-login