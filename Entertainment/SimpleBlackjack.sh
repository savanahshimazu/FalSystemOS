#!/bin/bash

# Function to calculate the total value of the cards
calculate_total() {
    local total=0
    local ace_count=0
    for card in "${@:2}"; do
        value=$(echo "$card" | cut -d' ' -f1)
        if [ "$value" == "Ace" ]; then
            total=$((total + 11))
            ace_count=$((ace_count + 1))
        elif [ "$value" == "King" ] || [ "$value" == "Queen" ] || [ "$value" == "Jack" ]; then
            total=$((total + 10))
        else
            total=$((total + value))
        fi
    done

    # Adjust total for Aces
    while [ $total -gt 21 ] && [ $ace_count -gt 0 ]; do
        total=$((total - 10))
        ace_count=$((ace_count - 1))
    done

    echo $total
}

# Function to display cards
display_cards() {
    local cards=("$@")
    local msg="Your cards:\n"
    for card in "${cards[@]}"; do
        msg="$msg$card\n"
    done
    dialog --msgbox "$msg" 10 40
}

# Function to generate a random card
get_card() {
    local suits=("Hearts" "Diamonds" "Clubs" "Spades")
    local values=("2" "3" "4" "5" "6" "7" "8" "9" "10" "Jack" "Queen" "King" "Ace")
    local suit=${suits[$((RANDOM % 4))]}
    local value=${values[$((RANDOM % 13))]}
    echo "$value of $suit"
}

# Function to check if the player wants to hit or stand
player_decision() {
    dialog --yesno "Do you want to Hit?" 10 40
    return $?
}

# Initialize variables
player_cards=()
dealer_cards=()

# Deal initial cards
player_cards+=("$(get_card)")
player_cards+=("$(get_card)")
dealer_cards+=("$(get_card)")
dealer_cards+=("$(get_card)")

# Display initial cards
display_cards "${player_cards[@]}"
dealer_hidden_card="${dealer_cards[0]}"

# Player's turn
while player_decision; do
    player_cards+=("$(get_card)")
    display_cards "${player_cards[@]}"
    player_total=$(calculate_total "${player_cards[@]}")
    if [ $player_total -gt 21 ]; then
        dialog --msgbox "You busted! Dealer wins." 10 40
        exit 0
    fi
done

# Dealer's turn
dealer_total=$(calculate_total "${dealer_cards[@]}")
while [ $dealer_total -lt 17 ]; do
    dealer_cards+=("$(get_card)")
    dealer_total=$(calculate_total "${dealer_cards[@]}")
done

# Display dealer's cards
dealer_msg="Dealer's cards:\n$dealer_hidden_card\n"
for ((i = 1; i < ${#dealer_cards[@]}; i++)); do
    dealer_msg="$dealer_msg${dealer_cards[$i]}\n"
done
dialog --msgbox "$dealer_msg" 10 40

# Determine winner
if [ $dealer_total -gt 21 ] || [ $player_total -gt $dealer_total ]; then
    dialog --msgbox "You win!" 10 40
elif [ $player_total -eq $dealer_total ]; then
    dialog --msgbox "It's a tie!" 10 40
else
    dialog --msgbox "Dealer wins." 10 40
fi

exit 0
