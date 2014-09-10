//
//  TDTodoList.h
//  Todo List
//
//  Created by Makoto Miyagawa on 9/5/14.
//  Copyright (c) 2014 Makoto Miyagawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDTarefa.h"
@class TDTodoList;

@protocol TDTodoListDelegate <NSObject>
- (void)todoListGetListaSuccess:(NSArray *)array;
- (void)todoListCreateTarefaSuccess:(TDTarefa *)tarefa;
- (void)todoListUpdateTarefaSuccess:(TDTarefa *)tarefa;
- (void)todoListRequestFailed:(NSError *)error;
@end

@interface TDTodoList : NSObject

@property (nonatomic, weak) id<TDTodoListDelegate> __weak delegate;

- (void)buscarLista;
- (void)criarTarefa:(TDTarefa *)tarefa;
- (void)atualizarTarefa:(TDTarefa *)tarefa;
@end
