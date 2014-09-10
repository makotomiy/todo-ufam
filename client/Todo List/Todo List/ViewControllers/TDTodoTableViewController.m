//
//  TDTodoTableViewController.m
//  Todo List
//
//  Created by Makoto Miyagawa on 9/5/14.
//  Copyright (c) 2014 Makoto Miyagawa. All rights reserved.
//

#import "TDTodoTableViewController.h"
#import "TDTarefaViewController.h"

@interface TDTodoTableViewController ()
{
    NSArray *listaDeTarefas;
    NSInteger indiceSelecionado;
}
- (IBAction)atualizarLista:(id)sender;
- (IBAction)criarTarefa:(id)sender;


@end

@implementation TDTodoTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    indiceSelecionado = -1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self atualizarLista:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listaDeTarefas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    TDTarefa *tarefa = [listaDeTarefas objectAtIndex:indexPath.row];
    
    cell.textLabel.text = tarefa.atividade;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    indiceSelecionado = indexPath.row;
    [self performSegueWithIdentifier:@"tarefa" sender:self];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    TDTarefa *tarefa = [listaDeTarefas objectAtIndex:indexPath.row];
    
    cell.backgroundColor = tarefa.isConcluido ? [UIColor colorWithRed:0.820 green:0.141 blue:1.000 alpha:1.000] : [UIColor whiteColor];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    TDTarefaViewController *vc = [segue destinationViewController];
    vc.delegate = self;
    
    if (indiceSelecionado >= 0) {
        vc.tarefa = [listaDeTarefas objectAtIndex:indiceSelecionado];
    }
}

# pragma mark - TodoList Delegate

- (void)todoListGetListaSuccess:(NSArray *)array
{
    listaDeTarefas = array;
    [self.tableView reloadData];
}

- (void)todoListCreateTarefaSuccess:(TDTarefa *)tarefa
{
    [self.navigationController popViewControllerAnimated:YES];
    [self atualizarLista:self];
}

- (void)todoListUpdateTarefaSuccess:(TDTarefa *)tarefa
{
    [self.navigationController popViewControllerAnimated:YES];
    [self atualizarLista:self];
}

- (void)todoListRequestFailed:(NSError *)error
{
    NSLog(@"ERRO!: %@", [error description]);
}

- (IBAction)atualizarLista:(id)sender {
    TDTodoList *todo = [[TDTodoList alloc] init];
    todo.delegate = self;
    [todo buscarLista];
}

- (IBAction)criarTarefa:(id)sender {
    indiceSelecionado = -1;
    [self performSegueWithIdentifier:@"tarefa" sender:self];
}
@end
