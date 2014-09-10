//
//  TDAtividadeViewController.h
//  Todo List
//
//  Created by Makoto Miyagawa on 9/5/14.
//  Copyright (c) 2014 Makoto Miyagawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDTodoList.h"

@interface TDTarefaViewController : UIViewController

@property (nonatomic, weak) id<TDTodoListDelegate> __weak delegate;
@property (nonatomic, strong) TDTarefa *tarefa;

@end
