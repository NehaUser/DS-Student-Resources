from operator import index


tasks = [
    {'name' : 'Write email to Jan', 'completed' : True},
    {'name' : 'Sweep front porch', 'completed' : True},
    {'name' : 'Call mom', 'completed' : False}
]

# Function to display all the tasks
def list_tasks():
    for index, task in enumerate(tasks):
        print(str.format('{}: {} (Completed: {})', index, task['name'], task['completed']))


# Function to add a new task in the list
def add_task():
    task_text = input('Please add a task: ')

    # Create a dictionary named new_task and set completed to False
    new_text = {'name' : task_text , 'completed' : False}

    #add new_task to the tasks list
    tasks.append(new_text)

# Function to delete the selected task    
def remove_task():
    list_tasks()
    rem_task_index = int(input('Please enter the task number you want to remove: '))

    # To check if valid entry
    valid_entry = False
    while valid_entry == False:
        if len(tasks) < rem_task_index+1:
            print("Enter a valid task number.")
            rem_task_index = int(input('Please enter the task number you want to remove: '))
        else:
            valid_entry = True

    # Delete the task from the list.
    tasks.remove(tasks[rem_task_index])       
     
# Function to mark a task complete
def mark_task_complete():
    list_tasks()
    task_complete_mark = int(input('Please enter the task number you completed: '))

    # To check if valid entry
    valid_entry = False
    while valid_entry == False:
        if len(tasks) < task_complete_mark+1:
            print("Enter a valid task number.")
            task_complete_mark = int(input('Please enter the task number you completed: '))
        else:
            valid_entry = True

    #Mark the task completed.
    tasks[task_complete_mark]['completed'] = True


menu_text = """
====================
1. List the tasks
2. Add a task
3. Remove a task
4. Mark task complete
5. Quit

What would you like to do? """

program_is_running = True

while program_is_running:
    decision = input(menu_text)
    if decision == '1': 
        list_tasks()

    elif decision == '2':
        add_task()
    
    elif decision == '3':
        remove_task()
    
    elif decision == '4':
        mark_task_complete()

    elif decision == '5':
        program_is_running = False
    else:
        print('please choose a valid option')


