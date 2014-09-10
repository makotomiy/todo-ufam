//
//  TDAtividadeViewController.m
//  Todo List
//
//  Created by Makoto Miyagawa on 9/5/14.
//  Copyright (c) 2014 Makoto Miyagawa. All rights reserved.
//

#import "TDTarefaViewController.h"

@interface TDTarefaViewController ()
@property (weak, nonatomic) IBOutlet UITextField *atividadeTextField;
@property (weak, nonatomic) IBOutlet UISwitch *concluidoSwitch;


- (IBAction)salvarAtividade:(id)sender;
@end

@implementation TDTarefaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_tarefa) {
        _atividadeTextField.text = _tarefa.atividade;
        _concluidoSwitch.on = [_tarefa isConcluido];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)salvarAtividade:(id)sender {
    if (!_tarefa) {
        _tarefa = [[TDTarefa alloc] init];
    }
    _tarefa.atividade = _atividadeTextField.text;
    _tarefa.concluido = @(_concluidoSwitch.isOn);
    
    TDTodoList *todo = [[TDTodoList alloc] init];
    todo.delegate = _delegate;

    if (_tarefa.idTarefa) {
        [todo atualizarTarefa:_tarefa];
    } else {
        [todo criarTarefa:_tarefa];
    }
}

@end
