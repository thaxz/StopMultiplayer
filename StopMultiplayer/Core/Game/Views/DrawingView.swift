//
//  DrawingView.swift
//  StopMultiplayer
//
//  Created by thaxz on 18/07/23.
//

import SwiftUI
import PencilKit

struct DrawingView: UIViewRepresentable {
    
    class Coordinator: NSObject, PKCanvasViewDelegate {
        var matchManager: MatchManager
        
        init(matchManager: MatchManager) {
            self.matchManager = matchManager
        }
        
        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            guard canvasView.isUserInteractionEnabled else {return}
            matchManager.sendData(canvasView.drawing.dataRepresentation(), mode: .reliable)
        }
        
    }
    
    @EnvironmentObject var matchManager: MatchManager
    @Binding var eraserEnabled: Bool
    
    func makeUIView(context: Context) -> PKCanvasView {
        let canvasView = PKCanvasView()
        canvasView.drawingPolicy = .anyInput
        canvasView.delegate = context.coordinator
        canvasView.tool = PKInkingTool(.pen, color: .black, width: 5)
        canvasView.isUserInteractionEnabled = matchManager.currentlyDrawing
        
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
        let wasDrawing = uiView.isUserInteractionEnabled
        uiView.isUserInteractionEnabled = matchManager.currentlyDrawing
        if !wasDrawing && matchManager.currentlyDrawing {
            uiView.drawing = PKDrawing()
        }
        
        if uiView.isUserInteractionEnabled || !matchManager.isInGame {
            uiView.drawing = matchManager.lastReceivedDrawing
        }
        uiView.tool = eraserEnabled ? PKEraserTool(.vector) : PKInkingTool(.pen, color: .black, width: 5)
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(matchManager: matchManager)
    }
    
}

struct DrawingView_Previews: PreviewProvider {
    @State static var eraser: Bool = false
    static var previews: some View {
        DrawingView(eraserEnabled: $eraser)
            .environmentObject(MatchManager())
    }
}
