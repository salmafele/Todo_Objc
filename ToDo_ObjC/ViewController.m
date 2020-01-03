//
//  ViewController.m
//  ToDo_ObjC
//
//  Created by Salma on 12/21/19.
//  Copyright © 2019 Salma. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIAlertViewDelegate>

@property (nonatomic) NSMutableArray *tasks;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tasks = @[@{@"task": @"Make toDo app in Obj-c"}, @{@"task": @"Go shopping"}].mutableCopy;
    
    self.navigationItem.title = @"ToDo List";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd target:self action:@selector(addNewTask:)];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//Adding tasks
-(void)addNewTask:(UIBarButtonItem *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"New Todo Task" message: @"Add your new task" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOK = [UIAlertAction actionWithTitle: @"Add task" style: UIAlertActionStyleDefault handler: nil]; // a block instead of nil
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle: @"Cancel" style: UIAlertActionStyleCancel handler: nil];
    
    [alertController addAction: actionOK];
    [alertController addAction: actionCancel];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Add task..";
        textField.delegate = self;
        
//        self.tasks = [[NSMutableArray alloc] init];

    }];
    
//    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//        textField.placeholder = @"Date";
//         textField.delegate = self;
//    }];
    
//    [self.tasks addObject: task];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}


//// alertView delegate
//-(void)alertView:(UIAlertContro *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if (buttonIndex != alertView.cancelButtonIndex) {
//
//        UITextField *taskField = [alertView textFieldAtIndex: 0]; // to add the task if there was any
//        NSString *taskName = taskField.text;
//        NSDictionary *task = @{@"task": taskName};
//        [self.tasks addObject: task];
//        [self.tableView insertRowsAtIndexPaths: @[[NSIndexPath indexPathForRow: self.tasks.count - 1 inSection: 0]] withRowAnimation: UITableViewRowAnimationAutomatic];
//    }
//}


// TableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tasks.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ToDoIemRow";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];
    
    NSDictionary *task = self.tasks[indexPath.row];
    
    cell.textLabel.text = task[@"task"];
    
    //check if item is completed or not
    if ([task[@"completed"] boolValue]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *task = [self.tasks[indexPath.row] mutableCopy];
    BOOL completed = [task[@"completed"] boolValue];
    task[@"completed"] = @(!completed);
    
    self.tasks[indexPath.row] = task;
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath: indexPath];
    cell.accessoryType = ([task[@"completed"] boolValue]) ? UITableViewCellAccessoryCheckmark: UITableViewCellAccessoryNone;
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
}

// past due tasks


@end
