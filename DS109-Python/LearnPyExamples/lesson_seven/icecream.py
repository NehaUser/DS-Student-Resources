def scoop_icecream(size, *toppings):
    """Give a summary of the ice cream cone you are making."""

    print("\nMaking a " + size + " ice cream cone with the following toppings:")
    for topping in toppings:
        print("- " + topping)