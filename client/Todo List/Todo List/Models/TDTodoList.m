//
//  TDTodoList.m
//  Todo List
//
//  Created by Makoto Miyagawa on 9/5/14.
//  Copyright (c) 2014 Makoto Miyagawa. All rights reserved.
//

#import "TDTodoList.h"
#import <AFNetworking/AFNetworking.h>

@interface TDTodoList ()
- (NSArray *)jsonToObjects:(NSArray *)dictArray;
- (void)requestFailedResponse:(NSError *)error;
@end

@implementation TDTodoList
static NSString *tarefasPath = @"http://todo-ufam.herokuapp.com/tarefas";

- (void)buscarLista
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:tarefasPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([_delegate respondsToSelector:@selector(todoListGetListaSuccess:)]) {
            [_delegate todoListGetListaSuccess:[self jsonToObjects:responseObject]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self requestFailedResponse:error];
    }];
}

- (void)criarTarefa:(TDTarefa *)tarefa
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:tarefasPath parameters:[tarefa dictionaryRepresentation]
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([_delegate respondsToSelector:@selector(todoListCreateTarefaSuccess:)]) {
                  [_delegate todoListCreateTarefaSuccess:[[TDTarefa alloc] initFromDictionary:responseObject]];
              }

          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [self requestFailedResponse:error];
          }];
}

- (void)atualizarTarefa:(TDTarefa *)tarefa
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager PUT:[tarefasPath stringByAppendingFormat:@"/%@", [tarefa.idTarefa stringValue]]
      parameters:[tarefa dictionaryRepresentation]
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if ([_delegate respondsToSelector:@selector(todoListUpdateTarefaSuccess:)]) {
                 [_delegate todoListUpdateTarefaSuccess:tarefa];
             }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [self requestFailedResponse:error];
         }];
}

- (NSArray *)jsonToObjects:(NSArray *)dictArray
{
    NSMutableArray *array = [@[] mutableCopy];
    for (NSDictionary *dict in dictArray) {
        [array addObject:[[TDTarefa alloc] initFromDictionary:dict]];
    }
    
    return array;
}

- (void)requestFailedResponse:(NSError *)error
{
    if ([_delegate respondsToSelector:@selector(todoListRequestFailed:)]) {
        [_delegate todoListRequestFailed:error];
    }
}
@end
