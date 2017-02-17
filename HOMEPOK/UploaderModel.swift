//
//  UploaderModel.swift
//  HOMEPOK - Catalog of Ukrainian vehicle plates
//
//  Created by Alexander Iashchuk on 2/12/17.
//  Copyright © 2015 Alexander Iashchuk (iAlexander), https://iashchuk.com
//
//  This application is released under the MIT license. All rights reserved.
//

import Foundation
import CoreGraphics

open class ChartBaseDataSet: NSObject
{
    public required override init()
    {
        super.init()
        
        // default color
        colors.append(NSUIColor(red: 140.0/255.0, green: 234.0/255.0, blue: 255.0/255.0, alpha: 1.0))
        valueColors.append(NSUIColor.black)
    }
    
    public init(label: String?)
    {
        super.init()
        
        // default color
        colors.append(NSUIColor(red: 140.0/255.0, green: 234.0/255.0, blue: 255.0/255.0, alpha: 1.0))
        valueColors.append(NSUIColor.black)
        
        self.label = label
    }
    
    // MARK: - Data functions and accessors
    
    /// Use this method to tell the data set that the underlying data has changed
    open func notifyDataSetChanged()
    {
        calcMinMax()
    }
    
    open func calcMinMax()
    {
        fatalError("calcMinMax is not implemented in ChartBaseDataSet")
    }
    
    open func calcMinMaxY(fromX: Double, toX: Double)
    {
        fatalError("calcMinMaxY(fromX:, toX:) is not implemented in ChartBaseDataSet")
    }
    
    open var yMin: Double
    {
        fatalError("yMin is not implemented in ChartBaseDataSet")
    }
    
    open var yMax: Double
    {
        fatalError("yMax is not implemented in ChartBaseDataSet")
    }
    
    open var xMin: Double
    {
        fatalError("xMin is not implemented in ChartBaseDataSet")
    }
    
    open var xMax: Double
    {
        fatalError("xMax is not implemented in ChartBaseDataSet")
    }
    
    open var entryCount: Int
    {
        fatalError("entryCount is not implemented in ChartBaseDataSet")
    }
    
    open func entryForIndex(_ i: Int) -> ChartDataEntry?
    {
        fatalError("entryForIndex is not implemented in ChartBaseDataSet")
    }
    
    open func entryForXValue(
        _ x: Double,
        closestToY y: Double,
        rounding: ChartDataSetRounding) -> ChartDataEntry?
    {
        fatalError("entryForXValue(x, closestToY, rounding) is not implemented in ChartBaseDataSet")
    }
    
    open func entryForXValue(
        _ x: Double,
        closestToY y: Double) -> ChartDataEntry?
    {
        fatalError("entryForXValue(x, closestToY) is not implemented in ChartBaseDataSet")
    }
    
    open func entriesForXValue(_ x: Double) -> [ChartDataEntry]
    {
        fatalError("entriesForXValue is not implemented in ChartBaseDataSet")
    }
    
    open func entryIndex(
        x xValue: Double,
        closestToY y: Double,
        rounding: ChartDataSetRounding) -> Int
    {
        fatalError("entryIndex(x, closestToY, rounding) is not implemented in ChartBaseDataSet")
    }
    
    open func entryIndex(entry e: ChartDataEntry) -> Int
    {
        fatalError("entryIndex(entry) is not implemented in ChartBaseDataSet")
    }
    
    open func addEntry(_ e: ChartDataEntry) -> Bool
    {
        fatalError("addEntry is not implemented in ChartBaseDataSet")
    }
    
    open func addEntryOrdered(_ e: ChartDataEntry) -> Bool
    {
        fatalError("addEntryOrdered is not implemented in ChartBaseDataSet")
    }
    
    open func removeEntry(_ entry: ChartDataEntry) -> Bool
    {
        fatalError("removeEntry is not implemented in ChartBaseDataSet")
    }
    
    open func removeEntry(index: Int) -> Bool
    {
        if let entry = entryForIndex(index)
        {
            return removeEntry(entry)
        }
        return false
    }
    
    open func removeEntry(x: Double) -> Bool
    {
        if let entry = entryForXValue(x, closestToY: Double.nan)
        {
            return removeEntry(entry)
        }
        return false
    }
    
    open func removeFirst() -> Bool
    {
        if entryCount > 0
        {
            if let entry = entryForIndex(0)
            {
                return removeEntry(entry)
            }
        }
        return false
    }
    
    open func removeLast() -> Bool
    {
        if entryCount > 0
        {
            if let entry = entryForIndex(entryCount - 1)
            {
                return removeEntry(entry)
            }
        }
        return false
    }
    
    open func contains(_ e: ChartDataEntry) -> Bool
    {
        fatalError("removeEntry is not implemented in ChartBaseDataSet")
    }
    
    open func clear()
    {
        fatalError("clear is not implemented in ChartBaseDataSet")
    }
    
    // MARK: - Styling functions and accessors
    
    /// All the colors that are used for this DataSet.
    /// Colors are reused as soon as the number of Entries the DataSet represents is higher than the size of the colors array.
    open var colors = [NSUIColor]()
    
    /// List representing all colors that are used for drawing the actual values for this DataSet
    open var valueColors = [NSUIColor]()
    
    /// The label string that describes the DataSet.
    open var label: String? = "DataSet"
    
    /// The axis this DataSet should be plotted against.
    open var axisDependency = YAxis.AxisDependency.left
    
    /// - returns: The color at the given index of the DataSet's color array.
    /// This prevents out-of-bounds by performing a modulus on the color index, so colours will repeat themselves.
    open func color(atIndex index: Int) -> NSUIColor
    {
        var index = index
        if index < 0
        {
            index = 0
        }
        return colors[index % colors.count]
    }
    
    /// Resets all colors of this DataSet and recreates the colors array.
    open func resetColors()
    {
        colors.removeAll(keepingCapacity: false)
    }
    
    /// Adds a new color to the colors array of the DataSet.
    /// - parameter color: the color to add
    open func addColor(_ color: NSUIColor)
    {
        colors.append(color)
    }
    
    /// Sets the one and **only** color that should be used for this DataSet.
    /// Internally, this recreates the colors array and adds the specified color.
    /// - parameter color: the color to set
    open func setColor(_ color: NSUIColor)
    {
        colors.removeAll(keepingCapacity: false)
        colors.append(color)
    }
    
    /// Sets colors to a single color a specific alpha value.
    /// - parameter color: the color to set
    /// - parameter alpha: alpha to apply to the set `color`
    open func setColor(_ color: NSUIColor, alpha: CGFloat)
    {
        setColor(color.withAlphaComponent(alpha))
    }
    
    /// Sets colors with a specific alpha value.
    /// - parameter colors: the colors to set
    /// - parameter alpha: alpha to apply to the set `colors`
    open func setColors(_ colors: [NSUIColor], alpha: CGFloat)
    {
        var colorsWithAlpha = colors
        
        for i in 0 ..< colorsWithAlpha.count
        {
            colorsWithAlpha[i] = colorsWithAlpha[i] .withAlphaComponent(alpha)
        }
        
        self.colors = colorsWithAlpha
    }
    
    /// Sets colors with a specific alpha value.
    /// - parameter colors: the colors to set
    /// - parameter alpha: alpha to apply to the set `colors`
    open func setColors(_ colors: NSUIColor...)
    {
        self.colors = colors
    }
    
    /// if true, value highlighting is enabled
    open var highlightEnabled = true
    
    /// - returns: `true` if value highlighting is enabled for this dataset
    open var isHighlightEnabled: Bool { return highlightEnabled }
    
    /// Custom formatter that is used instead of the auto-formatter if set
    internal var _valueFormatter: IValueFormatter?
    
    /// Custom formatter that is used instead of the auto-formatter if set
    open var valueFormatter: IValueFormatter?
        {
        get
        {
            if needsFormatter
            {
                return ChartUtils.defaultValueFormatter()
            }
            
            return _valueFormatter
        }
        set
        {
            if newValue == nil { return }
            
            _valueFormatter = newValue
        }
    }
    
    open var needsFormatter: Bool
    {
        return _valueFormatter == nil
    }
    
    /// Sets/get a single color for value text.
    /// Setting the color clears the colors array and adds a single color.
    /// Getting will return the first color in the array.
    open var valueTextColor: NSUIColor
        {
        get
        {
            return valueColors[0]
        }
        set
        {
            valueColors.removeAll(keepingCapacity: false)
            valueColors.append(newValue)
        }
    }
    
    /// - returns: The color at the specified index that is used for drawing the values inside the chart. Uses modulus internally.
    open func valueTextColorAt(_ index: Int) -> NSUIColor
    {
        var index = index
        if index < 0
        {
            index = 0
        }
        return valueColors[index % valueColors.count]
    }
    
    /// the font for the value-text labels
    open var valueFont: NSUIFont = NSUIFont.systemFont(ofSize: 7.0)
    
    /// The form to draw for this dataset in the legend.
    open var form = Legend.Form.default
    
    /// The form size to draw for this dataset in the legend.
    ///
    /// Return `NaN` to use the default legend form size.
    open var formSize: CGFloat = CGFloat.nan
    
    /// The line width for drawing the form of this dataset in the legend
    ///
    /// Return `NaN` to use the default legend form line width.
    open var formLineWidth: CGFloat = CGFloat.nan
    
    /// Line dash configuration for legend shapes that consist of lines.
    ///
    /// This is how much (in pixels) into the dash pattern are we starting from.
    open var formLineDashPhase: CGFloat = 0.0
    
    /// Line dash configuration for legend shapes that consist of lines.
    ///
    /// This is the actual dash pattern.
    /// I.e. [2, 3] will paint [--   --   ]
    /// [1, 3, 4, 2] will paint [-   ----  -   ----  ]
    open var formLineDashLengths: [CGFloat]? = nil
    
    /// Set this to true to draw y-values on the chart
    open var drawValuesEnabled = true
    
    /// - returns: `true` if y-value drawing is enabled, `false` ifnot
    open var isDrawValuesEnabled: Bool
    {
        return drawValuesEnabled
    }
    
    /// Set the visibility of this DataSet. If not visible, the DataSet will not be drawn to the chart upon refreshing it.
    open var visible = true
    
    /// - returns: `true` if this DataSet is visible inside the chart, or `false` ifit is currently hidden.
    open var isVisible: Bool
    {
        return visible
    }
    
    // MARK: - NSObject
    
    open override var description: String
    {
        return String(format: "%@, label: %@, %i entries", arguments: [NSStringFromClass(type(of: self)), self.label ?? "", self.entryCount])
    }
    
    open override var debugDescription: String
    {
        var desc = description + ":"
        
        for i in 0 ..< self.entryCount
        {
            desc += "\n" + (self.entryForIndex(i)?.description ?? "")
        }
        
        return desc
    }
    
    // MARK: - NSCopying
    
    open func copyWithZone(_ zone: NSZone?) -> AnyObject
    {
        let copy = type(of: self).init()
        
        copy.colors = colors
        copy.valueColors = valueColors
        copy.label = label
        
        return copy
    }
}

@objc
public protocol IBarChartDataSet: IBarLineScatterCandleBubbleChartDataSet
{
    // MARK: - Data functions and accessors
    
    // MARK: - Styling functions and accessors
    
    /// - returns: `true` if this DataSet is stacked (stacksize > 1) or not.
    var isStacked: Bool { get }
    
    /// - returns: The maximum number of bars that can be stacked upon another in this DataSet.
    var stackSize: Int { get }
    
    /// the color used for drawing the bar-shadows. The bar shadows is a surface behind the bar that indicates the maximum value
    var barShadowColor: NSUIColor { get set }
    
    /// the width used for drawing borders around the bars. If borderWidth == 0, no border will be drawn.
    var barBorderWidth : CGFloat { get set }
    
    /// the color drawing borders around the bars.
    var barBorderColor: NSUIColor { get set }
    
    /// the alpha value (transparency) that is used for drawing the highlight indicator bar. min = 0.0 (fully transparent), max = 1.0 (fully opaque)
    var highlightAlpha: CGFloat { get set }
    
    /// array of labels used to describe the different values of the stacked bars
    var stackLabels: [String] { get set }
}

@objc
public protocol IBarLineScatterCandleBubbleChartDataSet: IChartDataSet
{
    // MARK: - Data functions and accessors
    
    // MARK: - Styling functions and accessors
    
    var highlightColor: NSUIColor { get set }
    var highlightLineWidth: CGFloat { get set }
    var highlightLineDashPhase: CGFloat { get set }
    var highlightLineDashLengths: [CGFloat]? { get set }
}

@objc
public protocol ICandleChartDataSet: ILineScatterCandleRadarChartDataSet
{
    // MARK: - Data functions and accessors
    
    // MARK: - Styling functions and accessors
    
    /// the space that is left out on the left and right side of each candle,
    /// **default**: 0.1 (10%), max 0.45, min 0.0
    var barSpace: CGFloat { get set }
    
    /// should the candle bars show?
    /// when false, only "ticks" will show
    ///
    /// **default**: true
    var showCandleBar: Bool { get set }
    
    /// the width of the candle-shadow-line in pixels.
    ///
    /// **default**: 3.0
    var shadowWidth: CGFloat { get set }
    
    /// the color of the shadow line
    var shadowColor: NSUIColor? { get set }
    
    /// use candle color for the shadow
    var shadowColorSameAsCandle: Bool { get set }
    
    /// Is the shadow color same as the candle color?
    var isShadowColorSameAsCandle: Bool { get }
    
    /// color for open == close
    var neutralColor: NSUIColor? { get set }
    
    /// color for open > close
    var increasingColor: NSUIColor? { get set }
    
    /// color for open < close
    var decreasingColor: NSUIColor? { get set }
    
    /// Are increasing values drawn as filled?
    var increasingFilled: Bool { get set }
    
    /// Are increasing values drawn as filled?
    var isIncreasingFilled: Bool { get }
    
    /// Are decreasing values drawn as filled?
    var decreasingFilled: Bool { get set }
    
    /// Are decreasing values drawn as filled?
    var isDecreasingFilled: Bool { get }
}

@objc(ChartAnimatorDelegate)
public protocol AnimatorDelegate
{
    /// Called when the Animator has stepped.
    func animatorUpdated(_ animator: Animator)
    
    /// Called when the Animator has stopped.
    func animatorStopped(_ animator: Animator)
}

@objc(ChartAnimator)
open class Animator: NSObject
{
    open weak var delegate: AnimatorDelegate?
    open var updateBlock: (() -> Void)?
    open var stopBlock: (() -> Void)?
    
    /// the phase that is animated and influences the drawn values on the x-axis
    open var phaseX: Double = 1.0
    
    /// the phase that is animated and influences the drawn values on the y-axis
    open var phaseY: Double = 1.0
    
    fileprivate var _startTimeX: TimeInterval = 0.0
    fileprivate var _startTimeY: TimeInterval = 0.0
    fileprivate var _displayLink: NSUIDisplayLink?
    
    fileprivate var _durationX: TimeInterval = 0.0
    fileprivate var _durationY: TimeInterval = 0.0
    
    fileprivate var _endTimeX: TimeInterval = 0.0
    fileprivate var _endTimeY: TimeInterval = 0.0
    fileprivate var _endTime: TimeInterval = 0.0
    
    fileprivate var _enabledX: Bool = false
    fileprivate var _enabledY: Bool = false
    
    fileprivate var _easingX: ChartEasingFunctionBlock?
    fileprivate var _easingY: ChartEasingFunctionBlock?
    
    public override init()
    {
        super.init()
    }
    
    deinit
    {
        stop()
    }
    
    open func stop()
    {
        if _displayLink != nil
        {
            _displayLink?.remove(from: RunLoop.main, forMode: RunLoopMode.commonModes)
            _displayLink = nil
            
            _enabledX = false
            _enabledY = false
            
            // If we stopped an animation in the middle, we do not want to leave it like this
            if phaseX != 1.0 || phaseY != 1.0
            {
                phaseX = 1.0
                phaseY = 1.0
                
                if delegate != nil
                {
                    delegate!.animatorUpdated(self)
                }
                if updateBlock != nil
                {
                    updateBlock!()
                }
            }
            
            if delegate != nil
            {
                delegate!.animatorStopped(self)
            }
            if stopBlock != nil
            {
                stopBlock?()
            }
        }
    }
    
    fileprivate func updateAnimationPhases(_ currentTime: TimeInterval)
    {
        if _enabledX
        {
            let elapsedTime: TimeInterval = currentTime - _startTimeX
            let duration: TimeInterval = _durationX
            var elapsed: TimeInterval = elapsedTime
            if elapsed > duration
            {
                elapsed = duration
            }
            
            if _easingX != nil
            {
                phaseX = _easingX!(elapsed, duration)
            }
            else
            {
                phaseX = Double(elapsed / duration)
            }
        }
        
        if _enabledY
        {
            let elapsedTime: TimeInterval = currentTime - _startTimeY
            let duration: TimeInterval = _durationY
            var elapsed: TimeInterval = elapsedTime
            if elapsed > duration
            {
                elapsed = duration
            }
            
            if _easingY != nil
            {
                phaseY = _easingY!(elapsed, duration)
            }
            else
            {
                phaseY = Double(elapsed / duration)
            }
        }
    }
    
    @objc fileprivate func animationLoop()
    {
        let currentTime: TimeInterval = CACurrentMediaTime()
        
        updateAnimationPhases(currentTime)
        
        if delegate != nil
        {
            delegate!.animatorUpdated(self)
        }
        if updateBlock != nil
        {
            updateBlock!()
        }
        
        if currentTime >= _endTime
        {
            stop()
        }
    }
    
    /// Animates the drawing / rendering of the chart on both x- and y-axis with the specified animation time.
    /// If `animate(...)` is called, no further calling of `invalidate()` is necessary to refresh the chart.
    /// - parameter xAxisDuration: duration for animating the x axis
    /// - parameter yAxisDuration: duration for animating the y axis
    /// - parameter easingX: an easing function for the animation on the x axis
    /// - parameter easingY: an easing function for the animation on the y axis
    open func animate(xAxisDuration: TimeInterval, yAxisDuration: TimeInterval, easingX: ChartEasingFunctionBlock?, easingY: ChartEasingFunctionBlock?)
    {
        stop()
        
        _startTimeX = CACurrentMediaTime()
        _startTimeY = _startTimeX
        _durationX = xAxisDuration
        _durationY = yAxisDuration
        _endTimeX = _startTimeX + xAxisDuration
        _endTimeY = _startTimeY + yAxisDuration
        _endTime = _endTimeX > _endTimeY ? _endTimeX : _endTimeY
        _enabledX = xAxisDuration > 0.0
        _enabledY = yAxisDuration > 0.0
        
        _easingX = easingX
        _easingY = easingY
        
        // Take care of the first frame if rendering is already scheduled...
        updateAnimationPhases(_startTimeX)
        
        if _enabledX || _enabledY
        {
            _displayLink = NSUIDisplayLink(target: self, selector: #selector(animationLoop))
            _displayLink?.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
        }
    }
    
    /// Animates the drawing / rendering of the chart on both x- and y-axis with the specified animation time.
    /// If `animate(...)` is called, no further calling of `invalidate()` is necessary to refresh the chart.
    /// - parameter xAxisDuration: duration for animating the x axis
    /// - parameter yAxisDuration: duration for animating the y axis
    /// - parameter easingOptionX: the easing function for the animation on the x axis
    /// - parameter easingOptionY: the easing function for the animation on the y axis
    open func animate(xAxisDuration: TimeInterval, yAxisDuration: TimeInterval, easingOptionX: ChartEasingOption, easingOptionY: ChartEasingOption)
    {
        animate(xAxisDuration: xAxisDuration, yAxisDuration: yAxisDuration, easingX: easingFunctionFromOption(easingOptionX), easingY: easingFunctionFromOption(easingOptionY))
    }
    
    /// Animates the drawing / rendering of the chart on both x- and y-axis with the specified animation time.
    /// If `animate(...)` is called, no further calling of `invalidate()` is necessary to refresh the chart.
    /// - parameter xAxisDuration: duration for animating the x axis
    /// - parameter yAxisDuration: duration for animating the y axis
    /// - parameter easing: an easing function for the animation
    open func animate(xAxisDuration: TimeInterval, yAxisDuration: TimeInterval, easing: ChartEasingFunctionBlock?)
    {
        animate(xAxisDuration: xAxisDuration, yAxisDuration: yAxisDuration, easingX: easing, easingY: easing)
    }
    
    /// Animates the drawing / rendering of the chart on both x- and y-axis with the specified animation time.
    /// If `animate(...)` is called, no further calling of `invalidate()` is necessary to refresh the chart.
    /// - parameter xAxisDuration: duration for animating the x axis
    /// - parameter yAxisDuration: duration for animating the y axis
    /// - parameter easingOption: the easing function for the animation
    open func animate(xAxisDuration: TimeInterval, yAxisDuration: TimeInterval, easingOption: ChartEasingOption)
    {
        animate(xAxisDuration: xAxisDuration, yAxisDuration: yAxisDuration, easing: easingFunctionFromOption(easingOption))
    }
    
    /// Animates the drawing / rendering of the chart on both x- and y-axis with the specified animation time.
    /// If `animate(...)` is called, no further calling of `invalidate()` is necessary to refresh the chart.
    /// - parameter xAxisDuration: duration for animating the x axis
    /// - parameter yAxisDuration: duration for animating the y axis
    open func animate(xAxisDuration: TimeInterval, yAxisDuration: TimeInterval)
    {
        animate(xAxisDuration: xAxisDuration, yAxisDuration: yAxisDuration, easingOption: .easeInOutSine)
    }
    
    /// Animates the drawing / rendering of the chart the x-axis with the specified animation time.
    /// If `animate(...)` is called, no further calling of `invalidate()` is necessary to refresh the chart.
    /// - parameter xAxisDuration: duration for animating the x axis
    /// - parameter easing: an easing function for the animation
    open func animate(xAxisDuration: TimeInterval, easing: ChartEasingFunctionBlock?)
    {
        _startTimeX = CACurrentMediaTime()
        _durationX = xAxisDuration
        _endTimeX = _startTimeX + xAxisDuration
        _endTime = _endTimeX > _endTimeY ? _endTimeX : _endTimeY
        _enabledX = xAxisDuration > 0.0
        
        _easingX = easing
        
        // Take care of the first frame if rendering is already scheduled...
        updateAnimationPhases(_startTimeX)
        
        if _enabledX || _enabledY
        {
            if _displayLink == nil
            {
                _displayLink = NSUIDisplayLink(target: self, selector: #selector(animationLoop))
                _displayLink?.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
            }
        }
    }
    
    /// Animates the drawing / rendering of the chart the x-axis with the specified animation time.
    /// If `animate(...)` is called, no further calling of `invalidate()` is necessary to refresh the chart.
    /// - parameter xAxisDuration: duration for animating the x axis
    /// - parameter easingOption: the easing function for the animation
    open func animate(xAxisDuration: TimeInterval, easingOption: ChartEasingOption)
    {
        animate(xAxisDuration: xAxisDuration, easing: easingFunctionFromOption(easingOption))
    }
    
    /// Animates the drawing / rendering of the chart the x-axis with the specified animation time.
    /// If `animate(...)` is called, no further calling of `invalidate()` is necessary to refresh the chart.
    /// - parameter xAxisDuration: duration for animating the x axis
    open func animate(xAxisDuration: TimeInterval)
    {
        animate(xAxisDuration: xAxisDuration, easingOption: .easeInOutSine)
    }
    
    /// Animates the drawing / rendering of the chart the y-axis with the specified animation time.
    /// If `animate(...)` is called, no further calling of `invalidate()` is necessary to refresh the chart.
    /// - parameter yAxisDuration: duration for animating the y axis
    /// - parameter easing: an easing function for the animation
    open func animate(yAxisDuration: TimeInterval, easing: ChartEasingFunctionBlock?)
    {
        _startTimeY = CACurrentMediaTime()
        _durationY = yAxisDuration
        _endTimeY = _startTimeY + yAxisDuration
        _endTime = _endTimeX > _endTimeY ? _endTimeX : _endTimeY
        _enabledY = yAxisDuration > 0.0
        
        _easingY = easing
        
        // Take care of the first frame if rendering is already scheduled...
        updateAnimationPhases(_startTimeY)
        
        if _enabledX || _enabledY
        {
            if _displayLink == nil
            {
                _displayLink = NSUIDisplayLink(target: self, selector: #selector(animationLoop))
                _displayLink?.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
            }
        }
    }
    
    /// Animates the drawing / rendering of the chart the y-axis with the specified animation time.
    /// If `animate(...)` is called, no further calling of `invalidate()` is necessary to refresh the chart.
    /// - parameter yAxisDuration: duration for animating the y axis
    /// - parameter easingOption: the easing function for the animation
    open func animate(yAxisDuration: TimeInterval, easingOption: ChartEasingOption)
    {
        animate(yAxisDuration: yAxisDuration, easing: easingFunctionFromOption(easingOption))
    }
    
    /// Animates the drawing / rendering of the chart the y-axis with the specified animation time.
    /// If `animate(...)` is called, no further calling of `invalidate()` is necessary to refresh the chart.
    /// - parameter yAxisDuration: duration for animating the y axis
    open func animate(yAxisDuration: TimeInterval)
    {
        animate(yAxisDuration: yAxisDuration, easingOption: .easeInOutSine)
    }
}

//
//  CameraViewController.swift
//  HOMEPOK - Catalog of Ukrainian vehicle plates
//
//  Created by Alexander Iashchuk on 11/8/16.
//  Copyright © 2015 Alexander Iashchuk (iAlexander), https://iashchuk.com
//
//  This application is released under the MIT license. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import Speech

class CameraViewController: UIViewController, AVCaptureFileOutputRecordingDelegate, CLLocationManagerDelegate, SFSpeechRecognizerDelegate {
    
    // MARK: Constants and variables declaration
    
    let defaults = UserDefaults.standard
    var videosArray: [String] = Array()
    let savedVideosArrayKey = "savedVideosArray"
    let locationManager = CLLocationManager()
    
    // MARK: Speech recognition settings
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    var speechArray: [String] = Array()
    let savedSpeechArrayKey = "savedSpeechArray"
    @IBOutlet weak var recognizedTextLabel: UILabel!
    
    // Change the speech recognition language here
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en"))
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //        if let location = locations.first {
        //            print("Found user's location: \(location)")
        //        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find current user's location: \(error.localizedDescription)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestLocation()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        
        let cameraViewSize = CGRect(x: 0, y: 0, width: 375, height: 667)
        previewView.frame = cameraViewSize
        previewView.updateConstraintsIfNeeded()
        
        // Disable UI. The UI is enabled if and only if the session starts running.
        
        cameraButton.isEnabled = false
        recordButton.isEnabled = false
        
        // Set up the video preview view.
        
        previewView.session = session
        
        /*
         Check video authorization status. Video access is required and audio
         access is optional. If audio access is denied, audio is not recorded
         during movie recording.
         */
        
        // MARK: Request video recording authorization
        
        switch AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) {
        case .authorized:
            
            // The user has previously granted access to the camera.
            
            break
            
        case .notDetermined:
            
            /*
             The user has not yet been presented with the option to grant
             video access. We suspend the session queue to delay session
             setup until the access request has completed.
             
             Note that audio access will be implicitly requested when we
             create an AVCaptureDeviceInput for audio during session setup.
             */
            
            sessionQueue.suspend()
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { [unowned self] granted in
                if !granted {
                    self.setupResult = .notAuthorized
                }
                self.sessionQueue.resume()
            })
            
        default:
            // The user has previously denied access.
            setupResult = .notAuthorized
        }
        
        /*
         Setup the capture session.
         In general it is not safe to mutate an AVCaptureSession or any of its
         inputs, outputs, or connections from multiple threads at the same time.
         
         Why not do all of this on the main queue?
         Because AVCaptureSession.startRunning() is a blocking call which can
         take a long time. We dispatch session setup to the sessionQueue so
         that the main queue isn't blocked, which keeps the UI responsive.
         */
        
        sessionQueue.async { [unowned self] in
            self.configureSession()
        }
        
        // MARK: Request speech recognition authorization
        
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            
            switch authStatus {
            case .authorized:
                print("User granted access to speech recognition")
                //                isButtonEnabled = true
                
            case .denied:
                //                isButtonEnabled = false
                print("User denied access to speech recognition")
                
            case .restricted:
                //                isButtonEnabled = false
                print("Speech recognition restricted on this device")
                
            case .notDetermined:
                //                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }
            
            //            OperationQueue.main.addOperation() {
            //                self.microphoneButton.isEnabled = isButtonEnabled
            //            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let cameraViewSize = CGRect(x: 0, y: 0, width: 375, height: 667)
        previewView.frame = cameraViewSize
        previewView.updateConstraintsIfNeeded()
        
        sessionQueue.async {
            switch self.setupResult {
            case .success:
                
                // Only setup observers and start the session running if setup succeeded.
                
                self.addObservers()
                self.session.startRunning()
                self.isSessionRunning = self.session.isRunning
                
            case .notAuthorized:
                DispatchQueue.main.async { [unowned self] in
                    let message = NSLocalizedString("AVCam doesn't have permission to use the camera, please change privacy settings", comment: "Alert message when the user has denied access to the camera")
                    let alertController = UIAlertController(title: "AVCam", message: message, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"), style: .cancel, handler: nil))
                    alertController.addAction(UIAlertAction(title: NSLocalizedString("Settings", comment: "Alert button to open Settings"), style: .`default`, handler: { action in
                        UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
                    }))
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                
            case .configurationFailed:
                DispatchQueue.main.async { [unowned self] in
                    let message = NSLocalizedString("Unable to capture media", comment: "Alert message when something goes wrong during capture session configuration")
                    let alertController = UIAlertController(title: "AVCam", message: message, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"), style: .cancel, handler: nil))
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if audioEngine.isRunning {
            self.stopRecordingSpeech()
        }
        sessionQueue.async { [unowned self] in
            if self.setupResult == .success {
                self.session.stopRunning()
                self.isSessionRunning = self.session.isRunning
                self.removeObservers()
                self.locationManager.stopUpdatingLocation()
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
    }
    
    func canRotate() {}
    
    override var shouldAutorotate: Bool {
        
        // Disable autorotation of the interface when recording is in progress.
        
        if let movieFileOutput = movieFileOutput {
            return !movieFileOutput.isRecording
        }
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if let videoPreviewLayerConnection = previewView.videoPreviewLayer.connection {
            let deviceOrientation = UIDevice.current.orientation
            guard let newVideoOrientation = deviceOrientation.videoOrientation, deviceOrientation.isPortrait || deviceOrientation.isLandscape else {
                return
            }
            
            videoPreviewLayerConnection.videoOrientation = newVideoOrientation
        }
    }
    
    // MARK: Infinite speech recognition helpers.
    
    var recognizedText = ""
    var recognizedTextArray = [String]()
    var count = -1
    var continueSpeechRecognition = true
    
    // MARK: Speech recognition function.
    
    func startRecordingSpeech() {
        self.recognizedTextLabel.text = "…text recognized from speech is displayed here…"
        self.recognizedTextLabel.isHidden = false
        self.count = -1
        self.recognizedTextArray = [""]
        startRecording()
        print("Started speech recognition")
    }
    
    func stopRecordingSpeech() {
        print("Finished speech recognition")
        self.recognizedTextLabel.isHidden = true
        self.continueSpeechRecognition = false
        self.audioEngine.stop()
        self.recognitionRequest?.endAudio()
        if !self.recognizedTextArray.isEmpty {
            self.recognizedText = self.recognizedTextArray[0]
            for item in self.recognizedTextArray {
                if self.recognizedText != item {
                    if item != "" {
                        self.recognizedText = self.recognizedText + "\n" + item
                    }
                }
            }
        } else {
            self.recognizedText = "Ooops... We are sorry, but Siri could not recognize the speech. It can happen because of not using English language or your really poor internet connection..."
        }
        if self.recognizedText == "" {
            self.recognizedText = "Ooops... We are sorry, but Siri could not recognize the speech. It can happen because of not using English language or your really poor internet connection..."
        }
        print("Recognized text:\n\(self.recognizedText)")
        
        if self.defaults.array(forKey: self.savedSpeechArrayKey) != nil {
            self.speechArray = self.defaults.array(forKey: self.savedSpeechArrayKey) as! [String]
        }
        
        self.speechArray.append(self.recognizedText)
        self.defaults.set(self.speechArray, forKey: self.savedSpeechArrayKey)
    }
    
    func startRecording() {
        self.continueSpeechRecognition = true
        self.count += 1
        print("COUNT: \(self.count)")
        if self.count > 0 {
            self.recognizedTextArray.append("")
        }
        print("Recognized text array:\n\(self.recognizedTextArray)")
        
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        //        let audioSession = AVAudioSession.sharedInstance()
        //        do {
        //            try audioSession.setCategory(AVAudioSessionCategoryRecord)
        //            try audioSession.setMode(AVAudioSessionModeMeasurement)
        //            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        //        } catch {
        //            print("audioSession properties weren't set because of an error.")
        //        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let inputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil {
                self.recognizedTextArray[self.count] = (result?.bestTranscription.formattedString)!
                print("Recognized part of text -> \(self.recognizedTextArray[self.count])")
                self.recognizedTextLabel.text = self.recognizedTextArray[self.count]
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {
                print("Recognition ERROR: \(error)")
                print("Recognition ISFINAL: \(isFinal)")
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                if self.recognizedTextArray[self.count].isEmpty {
                    if self.count > 0 {
                        self.recognizedTextArray.remove(at: self.count)
                    } else {
                        self.recognizedTextArray[self.count] = ""
                    }
                    self.count -= 1
                    if self.continueSpeechRecognition {
                        print("Program started speech recognition (TOP)")
                        self.startRecording()
                    }
                    return
                }
                if self.continueSpeechRecognition {
                    print("Program started speech recognition (BOTTOM)")
                    self.startRecording()
                }
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
    }
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            print("Speech recognizer is enabled")
        } else {
            print("Speech recognizer is disabled")
        }
    }
    
    // Mark: Timer
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var startTime = TimeInterval()
    
    var timer:Timer = Timer()
    
    func startTimer() {
        if (!timer.isValid) {
            let aSelector : Selector = #selector(CameraViewController.updateTime)
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate
        }
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    func updateTime() {
        let currentTime = NSDate.timeIntervalSinceReferenceDate
        
        //Find the difference between current time and start time.
        
        var elapsedTime: TimeInterval = currentTime - startTime
        
        //calculate the minutes in elapsed time.
        
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (TimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        
        let seconds = UInt8(elapsedTime)
        elapsedTime -= TimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        
        // let fraction = UInt8(elapsedTime * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        
        timerLabel.text = "\(strMinutes):\(strSeconds)"
    }
    
    // MARK: Session Management
    
    private enum SessionSetupResult {
        case success
        case notAuthorized
        case configurationFailed
    }
    
    private let session = AVCaptureSession()
    
    private var isSessionRunning = false
    
    private let sessionQueue = DispatchQueue(label: "session queue", attributes: [], target: nil) // Communicate with the session and other session objects on this queue.
    
    private var setupResult: SessionSetupResult = .success
    
    var videoDeviceInput: AVCaptureDeviceInput!
    
    @IBOutlet private weak var previewView: PreviewView!
    
    // Call this on the session queue.
    
    private func configureSession() {
        if setupResult != .success {
            return
        }
        
        session.beginConfiguration()
        
        // MARK: Set the recording quality
        
        /*
         Here we can modify the quality of recorded video.
         
         This setting will decrease twice the size of video file
         */
        
        session.sessionPreset = AVCaptureSessionPreset1280x720
        
        
        /*
         This setting will set the biggest possible size of video file
         
         session.sessionPreset = AVCaptureSessionPresetInputPriority
         */
        
        //MARK: Add video input.
        
        do {
            var defaultVideoDevice: AVCaptureDevice?
            
            // Choose the back dual camera if available, otherwise default to a wide angle camera.
            
            if let dualCameraDevice = AVCaptureDevice.defaultDevice(withDeviceType: .builtInDuoCamera, mediaType: AVMediaTypeVideo, position: .back) {
                defaultVideoDevice = dualCameraDevice
            }
            else if let backCameraDevice = AVCaptureDevice.defaultDevice(withDeviceType: .builtInWideAngleCamera, mediaType: AVMediaTypeVideo, position: .back) {
                
                // If the back dual camera is not available, default to the back wide angle camera.
                
                defaultVideoDevice = backCameraDevice
            }
            else if let frontCameraDevice = AVCaptureDevice.defaultDevice(withDeviceType: .builtInWideAngleCamera, mediaType: AVMediaTypeVideo, position: .front) {
                
                // In some cases where users break their phones, the back wide angle camera is not available. In this case, we should default to the front wide angle camera.
                
                defaultVideoDevice = frontCameraDevice
            }
            
            let videoDeviceInput = try AVCaptureDeviceInput(device: defaultVideoDevice)
            
            if session.canAddInput(videoDeviceInput) {
                session.addInput(videoDeviceInput)
                self.videoDeviceInput = videoDeviceInput
                
                DispatchQueue.main.async {
                    
                    /*
                     Why are we dispatching this to the main queue?
                     Because AVCaptureVideoPreviewLayer is the backing layer for PreviewView and UIView
                     can only be manipulated on the main thread.
                     Note: As an exception to the above rule, it is not necessary to serialize video orientation changes
                     on the AVCaptureVideoPreviewLayer’s connection with other session manipulation.
                     
                     Use the status bar orientation as the initial video orientation. Subsequent orientation changes are
                     handled by CameraViewController.viewWillTransition(to:with:).
                     */
                    
                    let statusBarOrientation = UIApplication.shared.statusBarOrientation
                    var initialVideoOrientation: AVCaptureVideoOrientation = .portrait
                    if statusBarOrientation != .unknown {
                        if let videoOrientation = statusBarOrientation.videoOrientation {
                            initialVideoOrientation = videoOrientation
                        }
                    }
                    
                    self.previewView.videoPreviewLayer.connection.videoOrientation = initialVideoOrientation
                }
            }
            else {
                print("Could not add video device input to the session")
                setupResult = .configurationFailed
                session.commitConfiguration()
                return
            }
        }
        catch {
            print("Could not create video device input: \(error)")
            setupResult = .configurationFailed
            session.commitConfiguration()
            return
        }
        
        // MARK: Add audio input.
        
        do {
            let audioDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio)
            let audioDeviceInput = try AVCaptureDeviceInput(device: audioDevice)
            
            if session.canAddInput(audioDeviceInput) {
                session.addInput(audioDeviceInput)
            }
            else {
                print("Could not add audio device input to the session")
            }
        }
        catch {
            print("Could not create audio device input: \(error)")
        }
        
        // MARK: Add video output.
        
        let movieFileOutput = AVCaptureMovieFileOutput()
        
        if session.canAddOutput(movieFileOutput) {session.addOutput(movieFileOutput)
            if let connection = movieFileOutput.connection(withMediaType: AVMediaTypeVideo) {
                if connection.isVideoStabilizationSupported {
                    connection.preferredVideoStabilizationMode = .auto
                }
            }
            session.commitConfiguration()
            
            self.movieFileOutput = movieFileOutput
            
            DispatchQueue.main.async { [unowned self] in
                self.recordButton.isEnabled = true
            }
        }
    }
    
    @IBAction private func resumeInterruptedSession(_ resumeButton: UIButton)
    {
        sessionQueue.async { [unowned self] in
            
            /*
             The session might fail to start running, e.g., if a phone or FaceTime call is still
             using audio or video. A failure to start the session running will be communicated via
             a session runtime error notification. To avoid repeatedly failing to start the session
             running, we only try to restart the session running in the session runtime error handler
             if we aren't trying to resume the session running.
             */
            
            self.session.startRunning()
            self.isSessionRunning = self.session.isRunning
            if !self.session.isRunning {
                DispatchQueue.main.async { [unowned self] in
                    let message = NSLocalizedString("Unable to resume", comment: "Alert message when unable to resume the session running")
                    let alertController = UIAlertController(title: "AVCam", message: message, preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"), style: .cancel, handler: nil)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            else {
                DispatchQueue.main.async { [unowned self] in
                    self.resumeButton.isHidden = true
                }
            }
        }
    }
    
    // MARK: Device Configuration
    
    @IBOutlet private weak var cameraButton: UIButton!
    
    @IBOutlet private weak var cameraUnavailableLabel: UILabel!
    
    private let videoDeviceDiscoverySession = AVCaptureDeviceDiscoverySession(deviceTypes: [.builtInWideAngleCamera, .builtInDuoCamera], mediaType: AVMediaTypeVideo, position: .unspecified)!
    
    @IBAction private func changeCamera(_ cameraButton: UIButton) {
        cameraButton.isEnabled = false
        recordButton.isEnabled = false
        
        sessionQueue.async { [unowned self] in
            let currentVideoDevice = self.videoDeviceInput.device
            let currentPosition = currentVideoDevice!.position
            
            let preferredPosition: AVCaptureDevicePosition
            let preferredDeviceType: AVCaptureDeviceType
            
            switch currentPosition {
            case .unspecified, .front:
                preferredPosition = .back
                preferredDeviceType = .builtInDuoCamera
                
            case .back:
                preferredPosition = .front
                preferredDeviceType = .builtInWideAngleCamera
            }
            
            let devices = self.videoDeviceDiscoverySession.devices!
            var newVideoDevice: AVCaptureDevice? = nil
            
            // First, look for a device with both the preferred position and device type. Otherwise, look for a device with only the preferred position.
            
            if let device = devices.filter({ $0.position == preferredPosition && $0.deviceType == preferredDeviceType }).first {
                newVideoDevice = device
            }
            else if let device = devices.filter({ $0.position == preferredPosition }).first {
                newVideoDevice = device
            }
            
            if let videoDevice = newVideoDevice {
                do {
                    let videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
                    
                    self.session.beginConfiguration()
                    
                    // Remove the existing device input first, since using the front and back camera simultaneously is not supported.
                    
                    self.session.removeInput(self.videoDeviceInput)
                    
                    if self.session.canAddInput(videoDeviceInput) {
                        NotificationCenter.default.removeObserver(self, name: Notification.Name("AVCaptureDeviceSubjectAreaDidChangeNotification"), object: currentVideoDevice!)
                        
                        NotificationCenter.default.addObserver(self, selector: #selector(self.subjectAreaDidChange), name: Notification.Name("AVCaptureDeviceSubjectAreaDidChangeNotification"), object: videoDeviceInput.device)
                        
                        self.session.addInput(videoDeviceInput)
                        self.videoDeviceInput = videoDeviceInput
                    }
                    else {
                        self.session.addInput(self.videoDeviceInput);
                    }
                    
                    if let connection = self.movieFileOutput?.connection(withMediaType: AVMediaTypeVideo) {
                        if connection.isVideoStabilizationSupported {
                            connection.preferredVideoStabilizationMode = .auto
                        }
                    }
                    self.session.commitConfiguration()
                }
                catch {
                    print("Error occured while creating video device input: \(error)")
                }
            }
            
            DispatchQueue.main.async { [unowned self] in
                self.cameraButton.isEnabled = true
                self.cameraButton.isHidden = false
                self.recordButton.isEnabled = self.movieFileOutput != nil
            }
        }
    }
    
    @IBAction private func focusAndExposeTap(_ gestureRecognizer: UITapGestureRecognizer) {
        let devicePoint = self.previewView.videoPreviewLayer.captureDevicePointOfInterest(for: gestureRecognizer.location(in: gestureRecognizer.view))
        focus(with: .autoFocus, exposureMode: .autoExpose, at: devicePoint, monitorSubjectAreaChange: true)
    }
    
    private func focus(with focusMode: AVCaptureFocusMode, exposureMode: AVCaptureExposureMode, at devicePoint: CGPoint, monitorSubjectAreaChange: Bool) {
        sessionQueue.async { [unowned self] in
            if let device = self.videoDeviceInput.device {
                do {
                    try device.lockForConfiguration()
                    
                    /*
                     Setting (focus/exposure)PointOfInterest alone does not initiate a (focus/exposure) operation.
                     Call set(Focus/Exposure)Mode() to apply the new point of interest.
                     */
                    
                    if device.isFocusPointOfInterestSupported && device.isFocusModeSupported(focusMode) {
                        device.focusPointOfInterest = devicePoint
                        device.focusMode = focusMode
                    }
                    
                    if device.isExposurePointOfInterestSupported && device.isExposureModeSupported(exposureMode) {
                        device.exposurePointOfInterest = devicePoint
                        device.exposureMode = exposureMode
                    }
                    
                    device.isSubjectAreaChangeMonitoringEnabled = monitorSubjectAreaChange
                    device.unlockForConfiguration()
                }
                catch {
                    print("Could not lock device for the configuration: \(error)")
                }
            }
        }
    }
    
    // MARK: Recording Movies
    
    private var movieFileOutput: AVCaptureMovieFileOutput? = nil
    
    private var backgroundRecordingID: UIBackgroundTaskIdentifier? = nil
    
    @IBOutlet private weak var recordButton: UIButton!
    
    @IBOutlet private weak var resumeButton: UIButton!
    
    @IBAction private func toggleMovieRecording(_ recordButton: UIButton) {
        
        guard let movieFileOutput = self.movieFileOutput else {
            return
        }
        
        /*
         Disable the Camera button until recording finishes, and disable
         the Record button until recording starts or finishes.
         See the AVCaptureFileOutputRecordingDelegate methods.
         */
        
        cameraButton.isEnabled = false
        cameraButton.isHidden = true
        recordButton.isEnabled = false
        self.tabBarController?.tabBar.isHidden = true
        if timerLabel.isHidden {
            startTimer()
            timerLabel.isHidden = !timerLabel.isHidden
        } else {
            stopTimer()
            timerLabel.isHidden = !timerLabel.isHidden
        }
        
        /*
         Retrieve the video preview layer's video orientation on the main queue
         before entering the session queue. We do this to ensure UI elements are
         accessed on the main thread and session configuration is done on the session queue.
         */
        
        let videoPreviewLayerOrientation = previewView.videoPreviewLayer.connection.videoOrientation
        
        sessionQueue.async { [unowned self] in
            if !movieFileOutput.isRecording {
                
                //MARK: Play "Record started" sound
                
                AudioServicesPlaySystemSound(1117)
                
                if UIDevice.current.isMultitaskingSupported {
                    
                    /*
                     Setup background task.
                     This is needed because the `capture(_:, didFinishRecordingToOutputFileAt:, fromConnections:, error:)`
                     callback is not received until AVCam returns to the foreground unless you request background execution time.
                     This also ensures that there will be time to write the file to the photo library when AVCam is backgrounded.
                     To conclude this background execution, endBackgroundTask(_:) is called in
                     `capture(_:, didFinishRecordingToOutputFileAt:, fromConnections:, error:)` after the recorded file has been saved.
                     */
                    
                    self.backgroundRecordingID = UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
                }
                
                // Update the orientation on the movie file output video connection before starting recording.
                
                let movieFileOutputConnection = self.movieFileOutput?.connection(withMediaType: AVMediaTypeVideo)
                movieFileOutputConnection?.videoOrientation = videoPreviewLayerOrientation
                
                // MARK: Adding metadata with location to the movie
                
                self.locationManager.requestLocation()
                let location = self.locationManager.location
                let metadata = AVMutableMetadataItem()
                metadata.keySpace = AVMetadataKeySpaceQuickTimeMetadata
                metadata.key = AVMetadataQuickTimeMetadataKeyLocationISO6709 as NSString
                metadata.identifier = AVMetadataIdentifierQuickTimeMetadataLocationISO6709
                let lat = String(format: "%.8f", (location?.coordinate.latitude)!)
                let lon = String(format: "%.8f", (location?.coordinate.longitude)!)
                metadata.value = String("LAT_" + lat + "_LON_" + lon) as NSString
                
                movieFileOutput.metadata = [metadata]
                
                let currentDate = Date()
                let calendar = Calendar.current
                let year = calendar.component(.year, from: currentDate)
                let month = calendar.component(.month, from: currentDate)
                let day = calendar.component(.day, from: currentDate)
                let hour = calendar.component(.hour, from: currentDate)
                let minute = calendar.component(.minute, from: currentDate)
                let second = calendar.component(.second, from: currentDate)
                let nanosecond = calendar.component(.nanosecond, from: currentDate)
                var stringHour = String(hour)
                if stringHour.characters.count < 2 {
                    stringHour = String("0\(stringHour)")
                }
                var stringMinute = String(minute)
                if stringMinute.characters.count < 2 {
                    stringMinute = String("0\(stringMinute)")
                }
                let filename = "\(year)\(month)\(day)_\(stringHour)\(stringMinute)_\(second)\(nanosecond)_LAT\(lat)_LON\(lon)"
                
                // print("Recording file name: " + filename)
                // let outputFileName = NSUUID().uuidString
                
                let outputFileName = filename
                let outputFilePath = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as NSString).appendingPathComponent((outputFileName as NSString).appendingPathExtension("mov")!)
                
                // print("outputFilePath - " + outputFilePath)
                
                movieFileOutput.startRecording(toOutputFileURL: URL(fileURLWithPath: outputFilePath), recordingDelegate: self)
                
                if self.defaults.array(forKey: self.savedVideosArrayKey) != nil {
                    self.videosArray = self.defaults.array(forKey: self.savedVideosArrayKey) as! [String]
                    
                    //                    print(self.videosArray)
                }
                
                self.videosArray.append(filename)
                self.defaults.set(self.videosArray, forKey: self.savedVideosArrayKey)
            }
            else {
                movieFileOutput.stopRecording()
                //                AudioServicesPlaySystemSound(1118)
            }
        }
    }
    
    func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!) {
        
        // MARK: Start speech recognition
        
        self.startRecordingSpeech()
        
        // Enable the Record button to let the user stop the recording.
        
        DispatchQueue.main.async { [unowned self] in
            self.recordButton.isEnabled = true
            self.cameraButton.isHidden = true
            self.recordButton.imageView?.image = UIImage(named: "StopCameraButton")
            //self.recordButton.setTitle(NSLocalizedString("Stop", comment: "Recording button stop title"), for: [])
            
        }
    }
    
    func capture(_ captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAt outputFileURL: URL!, fromConnections connections: [Any]!, error: Error!) {
        
        /*
         Note that currentBackgroundRecordingID is used to end the background task
         associated with this recording. This allows a new recording to be started,
         associated with a new UIBackgroundTaskIdentifier, once the movie file output's
         `isRecording` property is back to false — which happens sometime after this method
         returns.
         
         Note: Since we use a unique file path for each recording, a new recording will
         not overwrite a recording currently being saved.
         */
        
        func cleanup() {
            let path = outputFileURL.path
            if FileManager.default.fileExists(atPath: path) {
                do {
                    try FileManager.default.removeItem(atPath: path)
                }
                catch {
                    print("Could not remove file at url: \(outputFileURL)")
                }
            }
            if let currentBackgroundRecordingID = backgroundRecordingID {
                backgroundRecordingID = UIBackgroundTaskInvalid
                if currentBackgroundRecordingID != UIBackgroundTaskInvalid {
                    UIApplication.shared.endBackgroundTask(currentBackgroundRecordingID)
                }
            }
        }
        
        var success = true
        
        if error != nil {
            print("Movie file finishing error: \(error)")
            success = (((error as NSError).userInfo[AVErrorRecordingSuccessfullyFinishedKey] as AnyObject).boolValue)!
        }
        if success {
            
            // MARK: File procession success
            
            print("File procession success")
            
            // MARK: Stop speech recognition
            
            self.stopRecordingSpeech()
            
            //MARK: Play "Record finished" sound
            
            AudioServicesPlaySystemSound(1118)
            
            // MARK: Save video inside application.
            
            do {
                let video = try NSData(contentsOf: outputFileURL, options: NSData.ReadingOptions())
                let fileName = videosArray.last!
                let docsPath: String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
                let moviePath = docsPath + "/" + fileName + ".mov"
                print("CameraViewController movie path: \(moviePath)")
                video.write(toFile: moviePath, atomically: false)
            } catch {
                print("Can't convert video data to data file")
                cleanup()
            }
            
            // MARK: Save video to dropbox.
            
            DispatchQueue.main.async {
                let saver = DropboxViewController()
                saver.uploadVideoFile(filePath: self.videosArray.last!)
            }
            
            /*
             // Save the movie file to the photo library and cleanup.
             
             PHPhotoLibrary.shared().performChanges({
             let options = PHAssetResourceCreationOptions()
             options.shouldMoveFile = true
             let creationRequest = PHAssetCreationRequest.forAsset()
             creationRequest.addResource(with: .video, fileURL: outputFileURL, options: options)
             }, completionHandler: { success, error in
             if !success {
             print("Could not save movie to photo library: \(error)")
             }
             cleanup()
             }
             )
             */
            
        }
        else {
            cleanup()
        }
        
        // Enable the Camera and Record buttons to let the user switch camera and start another recording.
        
        DispatchQueue.main.async { [unowned self] in
            
            // Only enable the ability to change camera if the device has more than one camera.
            
            self.cameraButton.isEnabled = self.videoDeviceDiscoverySession.uniqueDevicePositionsCount() > 1
            self.cameraButton.isHidden = false
            //self.cameraButton.isHidden = !(self.videoDeviceDiscoverySession.uniqueDevicePositionsCount() > 1)
            self.tabBarController?.tabBar.isHidden = false
            self.recordButton.imageView?.image = UIImage(named: "RecordCameraButton")
            //self.recordButton.setTitle(NSLocalizedString("Record", comment: "Recording button record title"), for: [])
            
            // Only enable the ability to record after 1 second
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.recordButton.isEnabled = true
            }
        }
    }
    
    // MARK: KVO and Notifications
    
    private var sessionRunningObserveContext = 0
    
    private func addObservers() {
        session.addObserver(self, forKeyPath: "running", options: .new, context: &sessionRunningObserveContext)
        
        NotificationCenter.default.addObserver(self, selector: #selector(subjectAreaDidChange), name: Notification.Name("AVCaptureDeviceSubjectAreaDidChangeNotification"), object: videoDeviceInput.device)
        NotificationCenter.default.addObserver(self, selector: #selector(sessionRuntimeError), name: Notification.Name("AVCaptureSessionRuntimeErrorNotification"), object: session)
        
        /*
         A session can only run when the app is full screen. It will be interrupted
         in a multi-app layout, introduced in iOS 9, see also the documentation of
         AVCaptureSessionInterruptionReason. Add observers to handle these session
         interruptions and show a preview is paused message. See the documentation
         of AVCaptureSessionWasInterruptedNotification for other interruption reasons.
         */
        
        NotificationCenter.default.addObserver(self, selector: #selector(sessionWasInterrupted), name: Notification.Name("AVCaptureSessionWasInterruptedNotification"), object: session)
        NotificationCenter.default.addObserver(self, selector: #selector(sessionInterruptionEnded), name: Notification.Name("AVCaptureSessionInterruptionEndedNotification"), object: session)
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self)
        
        session.removeObserver(self, forKeyPath: "running", context: &sessionRunningObserveContext)
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &sessionRunningObserveContext {
            let newValue = change?[.newKey] as AnyObject?
            guard let isSessionRunning = newValue?.boolValue else { return }
            
            DispatchQueue.main.async { [unowned self] in
                
                // Only enable the ability to change camera if the device has more than one camera.
                
                self.cameraButton.isEnabled = isSessionRunning && self.videoDeviceDiscoverySession.uniqueDevicePositionsCount() > 1
                self.recordButton.isEnabled = isSessionRunning && self.movieFileOutput != nil
            }
        }
        else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    func subjectAreaDidChange(notification: NSNotification) {
        let devicePoint = CGPoint(x: 0.5, y: 0.5)
        focus(with: .autoFocus, exposureMode: .continuousAutoExposure, at: devicePoint, monitorSubjectAreaChange: false)
    }
    
    func sessionRuntimeError(notification: NSNotification) {
        guard let errorValue = notification.userInfo?[AVCaptureSessionErrorKey] as? NSError else {
            return
        }
        
        let error = AVError(_nsError: errorValue)
        print("Capture session runtime error: \(error)")
        
        /*
         Automatically try to restart the session running if media services were
         reset and the last start running succeeded. Otherwise, enable the user
         to try to resume the session running.
         */
        
        if error.code == .mediaServicesWereReset {
            sessionQueue.async { [unowned self] in
                if self.isSessionRunning {
                    self.session.startRunning()
                    self.isSessionRunning = self.session.isRunning
                }
                else {
                    DispatchQueue.main.async { [unowned self] in
                        self.resumeButton.isHidden = false
                    }
                }
            }
        }
        else {
            resumeButton.isHidden = false
        }
    }
    
    func sessionWasInterrupted(notification: NSNotification) {
        
        /*
         In some scenarios we want to enable the user to resume the session running.
         For example, if music playback is initiated via control center while
         using AVCam, then the user can let AVCam resume
         the session running, which will stop music playback. Note that stopping
         music playback in control center will not automatically resume the session
         running. Also note that it is not always possible to resume, see `resumeInterruptedSession(_:)`.
         */
        
        if let userInfoValue = notification.userInfo?[AVCaptureSessionInterruptionReasonKey] as AnyObject?, let reasonIntegerValue = userInfoValue.integerValue, let reason = AVCaptureSessionInterruptionReason(rawValue: reasonIntegerValue) {
            print("Capture session was interrupted with the reason \(reason)")
            
            var showResumeButton = false
            
            if reason == AVCaptureSessionInterruptionReason.audioDeviceInUseByAnotherClient || reason == AVCaptureSessionInterruptionReason.videoDeviceInUseByAnotherClient {
                showResumeButton = true
            }
            else if reason == AVCaptureSessionInterruptionReason.videoDeviceNotAvailableWithMultipleForegroundApps {
                
                // Simply fade-in a label to inform the user that the camera is unavailable.
                
                cameraUnavailableLabel.alpha = 0
                cameraUnavailableLabel.isHidden = false
                UIView.animate(withDuration: 0.25) { [unowned self] in
                    self.cameraUnavailableLabel.alpha = 1
                }
            }
            
            if showResumeButton {
                
                // Simply fade-in a button to enable the user to try to resume the session running.
                
                resumeButton.alpha = 0
                resumeButton.isHidden = false
                UIView.animate(withDuration: 0.25) { [unowned self] in
                    self.resumeButton.alpha = 1
                }
            }
        }
    }
    
    func sessionInterruptionEnded(notification: NSNotification) {
        print("Capture session interruption ended")
        
        if !resumeButton.isHidden {
            UIView.animate(withDuration: 0.25,
                           animations: { [unowned self] in
                            self.resumeButton.alpha = 0
                }, completion: { [unowned self] finished in
                    self.resumeButton.isHidden = true
                }
            )
        }
        if !cameraUnavailableLabel.isHidden {
            UIView.animate(withDuration: 0.25,
                           animations: { [unowned self] in
                            self.cameraUnavailableLabel.alpha = 0
                }, completion: { [unowned self] finished in
                    self.cameraUnavailableLabel.isHidden = true
                }
            )
        }
    }
}

extension UIDeviceOrientation {
    var videoOrientation: AVCaptureVideoOrientation? {
        switch self {
        case .portrait: return .portrait
        case .portraitUpsideDown: return .portraitUpsideDown
        case .landscapeLeft: return .landscapeRight
        case .landscapeRight: return .landscapeLeft
        default: return nil
        }
    }
}

extension UIInterfaceOrientation {
    
    var videoOrientation: AVCaptureVideoOrientation? {
        switch self {
        case .portrait: return .portrait
        case .portraitUpsideDown: return .portraitUpsideDown
        case .landscapeLeft: return .landscapeLeft
        case .landscapeRight: return .landscapeRight
        default: return nil
        }
    }
    
}

extension AVCaptureDeviceDiscoverySession {
    
    func uniqueDevicePositionsCount() -> Int {
        var uniqueDevicePositions = [AVCaptureDevicePosition]()
        
        for device in devices {
            if !uniqueDevicePositions.contains(device.position) {
                uniqueDevicePositions.append(device.position)
            }
        }
        
        return uniqueDevicePositions.count
    }
    
}

extension SFSpeechRecognitionTaskDelegate {
    
    func speechRecognitionTask(_ task: SFSpeechRecognitionTask, didFinishSuccessfully successfully: Bool) {
        if successfully {
            print("+++++++++TRUE+++++++++")
        } else {
            print("---------FALSE---------")
        }
    }
    
    func speechRecognitionTask(_ task: SFSpeechRecognitionTask, didFinishRecognition recognitionResult: SFSpeechRecognitionResult) {
        //        console.text = console.text + "\n" + recognitionResult.bestTranscription.formattedString
        print("!!!SpeechRecognitionTask: \(recognitionResult.bestTranscription.formattedString)")
    }
    
}

//
//  CameraViewController.swift
//  HOMEPOK - Catalog of Ukrainian vehicle plates
//
//  Created by Alexander Iashchuk on 11/8/16.
//  Copyright © 2015 Alexander Iashchuk (iAlexander), https://iashchuk.com
//
//  This application is released under the MIT license. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import Speech

class CameraViewController: UIViewController, AVCaptureFileOutputRecordingDelegate, CLLocationManagerDelegate, SFSpeechRecognizerDelegate {
    
    // MARK: Constants and variables declaration
    
    let defaults = UserDefaults.standard
    var videosArray: [String] = Array()
    let savedVideosArrayKey = "savedVideosArray"
    let locationManager = CLLocationManager()
    
    // MARK: Speech recognition settings
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    var speechArray: [String] = Array()
    let savedSpeechArrayKey = "savedSpeechArray"
    @IBOutlet weak var recognizedTextLabel: UILabel!
    
    // Change the speech recognition language here
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en"))
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //        if let location = locations.first {
        //            print("Found user's location: \(location)")
        //        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find current user's location: \(error.localizedDescription)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestLocation()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        
        let cameraViewSize = CGRect(x: 0, y: 0, width: 375, height: 667)
        previewView.frame = cameraViewSize
        previewView.updateConstraintsIfNeeded()
        
        // Disable UI. The UI is enabled if and only if the session starts running.
        
        cameraButton.isEnabled = false
        recordButton.isEnabled = false
        
        // Set up the video preview view.
        
        previewView.session = session
        
        /*
         Check video authorization status. Video access is required and audio
         access is optional. If audio access is denied, audio is not recorded
         during movie recording.
         */
        
        // MARK: Request video recording authorization
        
        switch AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) {
        case .authorized:
            
            // The user has previously granted access to the camera.
            
            break
            
        case .notDetermined:
            
            /*
             The user has not yet been presented with the option to grant
             video access. We suspend the session queue to delay session
             setup until the access request has completed.
             
             Note that audio access will be implicitly requested when we
             create an AVCaptureDeviceInput for audio during session setup.
             */
            
            sessionQueue.suspend()
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { [unowned self] granted in
                if !granted {
                    self.setupResult = .notAuthorized
                }
                self.sessionQueue.resume()
            })
            
        default:
            // The user has previously denied access.
            setupResult = .notAuthorized
        }
        
        /*
         Setup the capture session.
         In general it is not safe to mutate an AVCaptureSession or any of its
         inputs, outputs, or connections from multiple threads at the same time.
         
         Why not do all of this on the main queue?
         Because AVCaptureSession.startRunning() is a blocking call which can
         take a long time. We dispatch session setup to the sessionQueue so
         that the main queue isn't blocked, which keeps the UI responsive.
         */
        
        sessionQueue.async { [unowned self] in
            self.configureSession()
        }
        
        // MARK: Request speech recognition authorization
        
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            
            switch authStatus {
            case .authorized:
                print("User granted access to speech recognition")
                //                isButtonEnabled = true
                
            case .denied:
                //                isButtonEnabled = false
                print("User denied access to speech recognition")
                
            case .restricted:
                //                isButtonEnabled = false
                print("Speech recognition restricted on this device")
                
            case .notDetermined:
                //                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }
            
            //            OperationQueue.main.addOperation() {
            //                self.microphoneButton.isEnabled = isButtonEnabled
            //            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let cameraViewSize = CGRect(x: 0, y: 0, width: 375, height: 667)
        previewView.frame = cameraViewSize
        previewView.updateConstraintsIfNeeded()
        
        sessionQueue.async {
            switch self.setupResult {
            case .success:
                
                // Only setup observers and start the session running if setup succeeded.
                
                self.addObservers()
                self.session.startRunning()
                self.isSessionRunning = self.session.isRunning
                
            case .notAuthorized:
                DispatchQueue.main.async { [unowned self] in
                    let message = NSLocalizedString("AVCam doesn't have permission to use the camera, please change privacy settings", comment: "Alert message when the user has denied access to the camera")
                    let alertController = UIAlertController(title: "AVCam", message: message, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"), style: .cancel, handler: nil))
                    alertController.addAction(UIAlertAction(title: NSLocalizedString("Settings", comment: "Alert button to open Settings"), style: .`default`, handler: { action in
                        UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
                    }))
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                
            case .configurationFailed:
                DispatchQueue.main.async { [unowned self] in
                    let message = NSLocalizedString("Unable to capture media", comment: "Alert message when something goes wrong during capture session configuration")
                    let alertController = UIAlertController(title: "AVCam", message: message, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"), style: .cancel, handler: nil))
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if audioEngine.isRunning {
            self.stopRecordingSpeech()
        }
        sessionQueue.async { [unowned self] in
            if self.setupResult == .success {
                self.session.stopRunning()
                self.isSessionRunning = self.session.isRunning
                self.removeObservers()
                self.locationManager.stopUpdatingLocation()
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
    }
    
    func canRotate() {}
    
    override var shouldAutorotate: Bool {
        
        // Disable autorotation of the interface when recording is in progress.
        
        if let movieFileOutput = movieFileOutput {
            return !movieFileOutput.isRecording
        }
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if let videoPreviewLayerConnection = previewView.videoPreviewLayer.connection {
            let deviceOrientation = UIDevice.current.orientation
            guard let newVideoOrientation = deviceOrientation.videoOrientation, deviceOrientation.isPortrait || deviceOrientation.isLandscape else {
                return
            }
            
            videoPreviewLayerConnection.videoOrientation = newVideoOrientation
        }
    }
    
    // MARK: Infinite speech recognition helpers.
    
    var recognizedText = ""
    var recognizedTextArray = [String]()
    var count = -1
    var continueSpeechRecognition = true
    
    // MARK: Speech recognition function.
    
    func startRecordingSpeech() {
        self.recognizedTextLabel.text = "…text recognized from speech is displayed here…"
        self.recognizedTextLabel.isHidden = false
        self.count = -1
        self.recognizedTextArray = [""]
        startRecording()
        print("Started speech recognition")
    }
    
    func stopRecordingSpeech() {
        print("Finished speech recognition")
        self.recognizedTextLabel.isHidden = true
        self.continueSpeechRecognition = false
        self.audioEngine.stop()
        self.recognitionRequest?.endAudio()
        if !self.recognizedTextArray.isEmpty {
            self.recognizedText = self.recognizedTextArray[0]
            for item in self.recognizedTextArray {
                if self.recognizedText != item {
                    if item != "" {
                        self.recognizedText = self.recognizedText + "\n" + item
                    }
                }
            }
        } else {
            self.recognizedText = "Ooops... We are sorry, but Siri could not recognize the speech. It can happen because of not using English language or your really poor internet connection..."
        }
        if self.recognizedText == "" {
            self.recognizedText = "Ooops... We are sorry, but Siri could not recognize the speech. It can happen because of not using English language or your really poor internet connection..."
        }
        print("Recognized text:\n\(self.recognizedText)")
        
        if self.defaults.array(forKey: self.savedSpeechArrayKey) != nil {
            self.speechArray = self.defaults.array(forKey: self.savedSpeechArrayKey) as! [String]
        }
        
        self.speechArray.append(self.recognizedText)
        self.defaults.set(self.speechArray, forKey: self.savedSpeechArrayKey)
    }
    
    func startRecording() {
        self.continueSpeechRecognition = true
        self.count += 1
        print("COUNT: \(self.count)")
        if self.count > 0 {
            self.recognizedTextArray.append("")
        }
        print("Recognized text array:\n\(self.recognizedTextArray)")
        
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        //        let audioSession = AVAudioSession.sharedInstance()
        //        do {
        //            try audioSession.setCategory(AVAudioSessionCategoryRecord)
        //            try audioSession.setMode(AVAudioSessionModeMeasurement)
        //            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        //        } catch {
        //            print("audioSession properties weren't set because of an error.")
        //        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let inputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil {
                self.recognizedTextArray[self.count] = (result?.bestTranscription.formattedString)!
                print("Recognized part of text -> \(self.recognizedTextArray[self.count])")
                self.recognizedTextLabel.text = self.recognizedTextArray[self.count]
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {
                print("Recognition ERROR: \(error)")
                print("Recognition ISFINAL: \(isFinal)")
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                if self.recognizedTextArray[self.count].isEmpty {
                    if self.count > 0 {
                        self.recognizedTextArray.remove(at: self.count)
                    } else {
                        self.recognizedTextArray[self.count] = ""
                    }
                    self.count -= 1
                    if self.continueSpeechRecognition {
                        print("Program started speech recognition (TOP)")
                        self.startRecording()
                    }
                    return
                }
                if self.continueSpeechRecognition {
                    print("Program started speech recognition (BOTTOM)")
                    self.startRecording()
                }
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
    }
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            print("Speech recognizer is enabled")
        } else {
            print("Speech recognizer is disabled")
        }
    }
    
    // Mark: Timer
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var startTime = TimeInterval()
    
    var timer:Timer = Timer()
    
    func startTimer() {
        if (!timer.isValid) {
            let aSelector : Selector = #selector(CameraViewController.updateTime)
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate
        }
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    func updateTime() {
        let currentTime = NSDate.timeIntervalSinceReferenceDate
        
        //Find the difference between current time and start time.
        
        var elapsedTime: TimeInterval = currentTime - startTime
        
        //calculate the minutes in elapsed time.
        
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (TimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        
        let seconds = UInt8(elapsedTime)
        elapsedTime -= TimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        
        // let fraction = UInt8(elapsedTime * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        
        timerLabel.text = "\(strMinutes):\(strSeconds)"
    }
    
    // MARK: Session Management
    
    private enum SessionSetupResult {
        case success
        case notAuthorized
        case configurationFailed
    }
    
    private let session = AVCaptureSession()
    
    private var isSessionRunning = false
    
    private let sessionQueue = DispatchQueue(label: "session queue", attributes: [], target: nil) // Communicate with the session and other session objects on this queue.
    
    private var setupResult: SessionSetupResult = .success
    
    var videoDeviceInput: AVCaptureDeviceInput!
    
    @IBOutlet private weak var previewView: PreviewView!
    
    // Call this on the session queue.
    
    private func configureSession() {
        if setupResult != .success {
            return
        }
        
        session.beginConfiguration()
        
        // MARK: Set the recording quality
        
        /*
         Here we can modify the quality of recorded video.
         
         This setting will decrease twice the size of video file
         */
        
        session.sessionPreset = AVCaptureSessionPreset1280x720
        
        
        /*
         This setting will set the biggest possible size of video file
         
         session.sessionPreset = AVCaptureSessionPresetInputPriority
         */
        
        //MARK: Add video input.
        
        do {
            var defaultVideoDevice: AVCaptureDevice?
            
            // Choose the back dual camera if available, otherwise default to a wide angle camera.
            
            if let dualCameraDevice = AVCaptureDevice.defaultDevice(withDeviceType: .builtInDuoCamera, mediaType: AVMediaTypeVideo, position: .back) {
                defaultVideoDevice = dualCameraDevice
            }
            else if let backCameraDevice = AVCaptureDevice.defaultDevice(withDeviceType: .builtInWideAngleCamera, mediaType: AVMediaTypeVideo, position: .back) {
                
                // If the back dual camera is not available, default to the back wide angle camera.
                
                defaultVideoDevice = backCameraDevice
            }
            else if let frontCameraDevice = AVCaptureDevice.defaultDevice(withDeviceType: .builtInWideAngleCamera, mediaType: AVMediaTypeVideo, position: .front) {
                
                // In some cases where users break their phones, the back wide angle camera is not available. In this case, we should default to the front wide angle camera.
                
                defaultVideoDevice = frontCameraDevice
            }
            
            let videoDeviceInput = try AVCaptureDeviceInput(device: defaultVideoDevice)
            
            if session.canAddInput(videoDeviceInput) {
                session.addInput(videoDeviceInput)
                self.videoDeviceInput = videoDeviceInput
                
                DispatchQueue.main.async {
                    
                    /*
                     Why are we dispatching this to the main queue?
                     Because AVCaptureVideoPreviewLayer is the backing layer for PreviewView and UIView
                     can only be manipulated on the main thread.
                     Note: As an exception to the above rule, it is not necessary to serialize video orientation changes
                     on the AVCaptureVideoPreviewLayer’s connection with other session manipulation.
                     
                     Use the status bar orientation as the initial video orientation. Subsequent orientation changes are
                     handled by CameraViewController.viewWillTransition(to:with:).
                     */
                    
                    let statusBarOrientation = UIApplication.shared.statusBarOrientation
                    var initialVideoOrientation: AVCaptureVideoOrientation = .portrait
                    if statusBarOrientation != .unknown {
                        if let videoOrientation = statusBarOrientation.videoOrientation {
                            initialVideoOrientation = videoOrientation
                        }
                    }
                    
                    self.previewView.videoPreviewLayer.connection.videoOrientation = initialVideoOrientation
                }
            }
            else {
                print("Could not add video device input to the session")
                setupResult = .configurationFailed
                session.commitConfiguration()
                return
            }
        }
        catch {
            print("Could not create video device input: \(error)")
            setupResult = .configurationFailed
            session.commitConfiguration()
            return
        }
        
        // MARK: Add audio input.
        
        do {
            let audioDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio)
            let audioDeviceInput = try AVCaptureDeviceInput(device: audioDevice)
            
            if session.canAddInput(audioDeviceInput) {
                session.addInput(audioDeviceInput)
            }
            else {
                print("Could not add audio device input to the session")
            }
        }
        catch {
            print("Could not create audio device input: \(error)")
        }
        
        // MARK: Add video output.
        
        let movieFileOutput = AVCaptureMovieFileOutput()
        
        if session.canAddOutput(movieFileOutput) {session.addOutput(movieFileOutput)
            if let connection = movieFileOutput.connection(withMediaType: AVMediaTypeVideo) {
                if connection.isVideoStabilizationSupported {
                    connection.preferredVideoStabilizationMode = .auto
                }
            }
            session.commitConfiguration()
            
            self.movieFileOutput = movieFileOutput
            
            DispatchQueue.main.async { [unowned self] in
                self.recordButton.isEnabled = true
            }
        }
    }
    
    @IBAction private func resumeInterruptedSession(_ resumeButton: UIButton)
    {
        sessionQueue.async { [unowned self] in
            
            /*
             The session might fail to start running, e.g., if a phone or FaceTime call is still
             using audio or video. A failure to start the session running will be communicated via
             a session runtime error notification. To avoid repeatedly failing to start the session
             running, we only try to restart the session running in the session runtime error handler
             if we aren't trying to resume the session running.
             */
            
            self.session.startRunning()
            self.isSessionRunning = self.session.isRunning
            if !self.session.isRunning {
                DispatchQueue.main.async { [unowned self] in
                    let message = NSLocalizedString("Unable to resume", comment: "Alert message when unable to resume the session running")
                    let alertController = UIAlertController(title: "AVCam", message: message, preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"), style: .cancel, handler: nil)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            else {
                DispatchQueue.main.async { [unowned self] in
                    self.resumeButton.isHidden = true
                }
            }
        }
    }
    
    // MARK: Device Configuration
    
    @IBOutlet private weak var cameraButton: UIButton!
    
    @IBOutlet private weak var cameraUnavailableLabel: UILabel!
    
    private let videoDeviceDiscoverySession = AVCaptureDeviceDiscoverySession(deviceTypes: [.builtInWideAngleCamera, .builtInDuoCamera], mediaType: AVMediaTypeVideo, position: .unspecified)!
    
    @IBAction private func changeCamera(_ cameraButton: UIButton) {
        cameraButton.isEnabled = false
        recordButton.isEnabled = false
        
        sessionQueue.async { [unowned self] in
            let currentVideoDevice = self.videoDeviceInput.device
            let currentPosition = currentVideoDevice!.position
            
            let preferredPosition: AVCaptureDevicePosition
            let preferredDeviceType: AVCaptureDeviceType
            
            switch currentPosition {
            case .unspecified, .front:
                preferredPosition = .back
                preferredDeviceType = .builtInDuoCamera
                
            case .back:
                preferredPosition = .front
                preferredDeviceType = .builtInWideAngleCamera
            }
            
            let devices = self.videoDeviceDiscoverySession.devices!
            var newVideoDevice: AVCaptureDevice? = nil
            
            // First, look for a device with both the preferred position and device type. Otherwise, look for a device with only the preferred position.
            
            if let device = devices.filter({ $0.position == preferredPosition && $0.deviceType == preferredDeviceType }).first {
                newVideoDevice = device
            }
            else if let device = devices.filter({ $0.position == preferredPosition }).first {
                newVideoDevice = device
            }
            
            if let videoDevice = newVideoDevice {
                do {
                    let videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
                    
                    self.session.beginConfiguration()
                    
                    // Remove the existing device input first, since using the front and back camera simultaneously is not supported.
                    
                    self.session.removeInput(self.videoDeviceInput)
                    
                    if self.session.canAddInput(videoDeviceInput) {
                        NotificationCenter.default.removeObserver(self, name: Notification.Name("AVCaptureDeviceSubjectAreaDidChangeNotification"), object: currentVideoDevice!)
                        
                        NotificationCenter.default.addObserver(self, selector: #selector(self.subjectAreaDidChange), name: Notification.Name("AVCaptureDeviceSubjectAreaDidChangeNotification"), object: videoDeviceInput.device)
                        
                        self.session.addInput(videoDeviceInput)
                        self.videoDeviceInput = videoDeviceInput
                    }
                    else {
                        self.session.addInput(self.videoDeviceInput);
                    }
                    
                    if let connection = self.movieFileOutput?.connection(withMediaType: AVMediaTypeVideo) {
                        if connection.isVideoStabilizationSupported {
                            connection.preferredVideoStabilizationMode = .auto
                        }
                    }
                    self.session.commitConfiguration()
                }
                catch {
                    print("Error occured while creating video device input: \(error)")
                }
            }
            
            DispatchQueue.main.async { [unowned self] in
                self.cameraButton.isEnabled = true
                self.cameraButton.isHidden = false
                self.recordButton.isEnabled = self.movieFileOutput != nil
            }
        }
    }
    
    @IBAction private func focusAndExposeTap(_ gestureRecognizer: UITapGestureRecognizer) {
        let devicePoint = self.previewView.videoPreviewLayer.captureDevicePointOfInterest(for: gestureRecognizer.location(in: gestureRecognizer.view))
        focus(with: .autoFocus, exposureMode: .autoExpose, at: devicePoint, monitorSubjectAreaChange: true)
    }
    
    private func focus(with focusMode: AVCaptureFocusMode, exposureMode: AVCaptureExposureMode, at devicePoint: CGPoint, monitorSubjectAreaChange: Bool) {
        sessionQueue.async { [unowned self] in
            if let device = self.videoDeviceInput.device {
                do {
                    try device.lockForConfiguration()
                    
                    /*
                     Setting (focus/exposure)PointOfInterest alone does not initiate a (focus/exposure) operation.
                     Call set(Focus/Exposure)Mode() to apply the new point of interest.
                     */
                    
                    if device.isFocusPointOfInterestSupported && device.isFocusModeSupported(focusMode) {
                        device.focusPointOfInterest = devicePoint
                        device.focusMode = focusMode
                    }
                    
                    if device.isExposurePointOfInterestSupported && device.isExposureModeSupported(exposureMode) {
                        device.exposurePointOfInterest = devicePoint
                        device.exposureMode = exposureMode
                    }
                    
                    device.isSubjectAreaChangeMonitoringEnabled = monitorSubjectAreaChange
                    device.unlockForConfiguration()
                }
                catch {
                    print("Could not lock device for the configuration: \(error)")
                }
            }
        }
    }
    
    // MARK: Recording Movies
    
    private var movieFileOutput: AVCaptureMovieFileOutput? = nil
    
    private var backgroundRecordingID: UIBackgroundTaskIdentifier? = nil
    
    @IBOutlet private weak var recordButton: UIButton!
    
    @IBOutlet private weak var resumeButton: UIButton!
    
    @IBAction private func toggleMovieRecording(_ recordButton: UIButton) {
        
        guard let movieFileOutput = self.movieFileOutput else {
            return
        }
        
        /*
         Disable the Camera button until recording finishes, and disable
         the Record button until recording starts or finishes.
         See the AVCaptureFileOutputRecordingDelegate methods.
         */
        
        cameraButton.isEnabled = false
        cameraButton.isHidden = true
        recordButton.isEnabled = false
        self.tabBarController?.tabBar.isHidden = true
        if timerLabel.isHidden {
            startTimer()
            timerLabel.isHidden = !timerLabel.isHidden
        } else {
            stopTimer()
            timerLabel.isHidden = !timerLabel.isHidden
        }
        
        /*
         Retrieve the video preview layer's video orientation on the main queue
         before entering the session queue. We do this to ensure UI elements are
         accessed on the main thread and session configuration is done on the session queue.
         */
        
        let videoPreviewLayerOrientation = previewView.videoPreviewLayer.connection.videoOrientation
        
        sessionQueue.async { [unowned self] in
            if !movieFileOutput.isRecording {
                
                //MARK: Play "Record started" sound
                
                AudioServicesPlaySystemSound(1117)
                
                if UIDevice.current.isMultitaskingSupported {
                    
                    /*
                     Setup background task.
                     This is needed because the `capture(_:, didFinishRecordingToOutputFileAt:, fromConnections:, error:)`
                     callback is not received until AVCam returns to the foreground unless you request background execution time.
                     This also ensures that there will be time to write the file to the photo library when AVCam is backgrounded.
                     To conclude this background execution, endBackgroundTask(_:) is called in
                     `capture(_:, didFinishRecordingToOutputFileAt:, fromConnections:, error:)` after the recorded file has been saved.
                     */
                    
                    self.backgroundRecordingID = UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
                }
                
                // Update the orientation on the movie file output video connection before starting recording.
                
                let movieFileOutputConnection = self.movieFileOutput?.connection(withMediaType: AVMediaTypeVideo)
                movieFileOutputConnection?.videoOrientation = videoPreviewLayerOrientation
                
                // MARK: Adding metadata with location to the movie
                
                self.locationManager.requestLocation()
                let location = self.locationManager.location
                let metadata = AVMutableMetadataItem()
                metadata.keySpace = AVMetadataKeySpaceQuickTimeMetadata
                metadata.key = AVMetadataQuickTimeMetadataKeyLocationISO6709 as NSString
                metadata.identifier = AVMetadataIdentifierQuickTimeMetadataLocationISO6709
                let lat = String(format: "%.8f", (location?.coordinate.latitude)!)
                let lon = String(format: "%.8f", (location?.coordinate.longitude)!)
                metadata.value = String("LAT_" + lat + "_LON_" + lon) as NSString
                
                movieFileOutput.metadata = [metadata]
                
                let currentDate = Date()
                let calendar = Calendar.current
                let year = calendar.component(.year, from: currentDate)
                let month = calendar.component(.month, from: currentDate)
                let day = calendar.component(.day, from: currentDate)
                let hour = calendar.component(.hour, from: currentDate)
                let minute = calendar.component(.minute, from: currentDate)
                let second = calendar.component(.second, from: currentDate)
                let nanosecond = calendar.component(.nanosecond, from: currentDate)
                var stringHour = String(hour)
                if stringHour.characters.count < 2 {
                    stringHour = String("0\(stringHour)")
                }
                var stringMinute = String(minute)
                if stringMinute.characters.count < 2 {
                    stringMinute = String("0\(stringMinute)")
                }
                let filename = "\(year)\(month)\(day)_\(stringHour)\(stringMinute)_\(second)\(nanosecond)_LAT\(lat)_LON\(lon)"
                
                // print("Recording file name: " + filename)
                // let outputFileName = NSUUID().uuidString
                
                let outputFileName = filename
                let outputFilePath = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as NSString).appendingPathComponent((outputFileName as NSString).appendingPathExtension("mov")!)
                
                // print("outputFilePath - " + outputFilePath)
                
                movieFileOutput.startRecording(toOutputFileURL: URL(fileURLWithPath: outputFilePath), recordingDelegate: self)
                
                if self.defaults.array(forKey: self.savedVideosArrayKey) != nil {
                    self.videosArray = self.defaults.array(forKey: self.savedVideosArrayKey) as! [String]
                    
                    //                    print(self.videosArray)
                }
                
                self.videosArray.append(filename)
                self.defaults.set(self.videosArray, forKey: self.savedVideosArrayKey)
            }
            else {
                movieFileOutput.stopRecording()
                //                AudioServicesPlaySystemSound(1118)
            }
        }
    }
    
    func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!) {
        
        // MARK: Start speech recognition
        
        self.startRecordingSpeech()
        
        // Enable the Record button to let the user stop the recording.
        
        DispatchQueue.main.async { [unowned self] in
            self.recordButton.isEnabled = true
            self.cameraButton.isHidden = true
            self.recordButton.imageView?.image = UIImage(named: "StopCameraButton")
            //self.recordButton.setTitle(NSLocalizedString("Stop", comment: "Recording button stop title"), for: [])
            
        }
    }
    
    func capture(_ captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAt outputFileURL: URL!, fromConnections connections: [Any]!, error: Error!) {
        
        /*
         Note that currentBackgroundRecordingID is used to end the background task
         associated with this recording. This allows a new recording to be started,
         associated with a new UIBackgroundTaskIdentifier, once the movie file output's
         `isRecording` property is back to false — which happens sometime after this method
         returns.
         
         Note: Since we use a unique file path for each recording, a new recording will
         not overwrite a recording currently being saved.
         */
        
        func cleanup() {
            let path = outputFileURL.path
            if FileManager.default.fileExists(atPath: path) {
                do {
                    try FileManager.default.removeItem(atPath: path)
                }
                catch {
                    print("Could not remove file at url: \(outputFileURL)")
                }
            }
            if let currentBackgroundRecordingID = backgroundRecordingID {
                backgroundRecordingID = UIBackgroundTaskInvalid
                if currentBackgroundRecordingID != UIBackgroundTaskInvalid {
                    UIApplication.shared.endBackgroundTask(currentBackgroundRecordingID)
                }
            }
        }
        
        var success = true
        
        if error != nil {
            print("Movie file finishing error: \(error)")
            success = (((error as NSError).userInfo[AVErrorRecordingSuccessfullyFinishedKey] as AnyObject).boolValue)!
        }
        if success {
            
            // MARK: File procession success
            
            print("File procession success")
            
            // MARK: Stop speech recognition
            
            self.stopRecordingSpeech()
            
            //MARK: Play "Record finished" sound
            
            AudioServicesPlaySystemSound(1118)
            
            // MARK: Save video inside application.
            
            do {
                let video = try NSData(contentsOf: outputFileURL, options: NSData.ReadingOptions())
                let fileName = videosArray.last!
                let docsPath: String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
                let moviePath = docsPath + "/" + fileName + ".mov"
                print("CameraViewController movie path: \(moviePath)")
                video.write(toFile: moviePath, atomically: false)
            } catch {
                print("Can't convert video data to data file")
                cleanup()
            }
            
            // MARK: Save video to dropbox.
            
            DispatchQueue.main.async {
                let saver = DropboxViewController()
                saver.uploadVideoFile(filePath: self.videosArray.last!)
            }
            
            /*
             // Save the movie file to the photo library and cleanup.
             
             PHPhotoLibrary.shared().performChanges({
             let options = PHAssetResourceCreationOptions()
             options.shouldMoveFile = true
             let creationRequest = PHAssetCreationRequest.forAsset()
             creationRequest.addResource(with: .video, fileURL: outputFileURL, options: options)
             }, completionHandler: { success, error in
             if !success {
             print("Could not save movie to photo library: \(error)")
             }
             cleanup()
             }
             )
             */
            
        }
        else {
            cleanup()
        }
        
        // Enable the Camera and Record buttons to let the user switch camera and start another recording.
        
        DispatchQueue.main.async { [unowned self] in
            
            // Only enable the ability to change camera if the device has more than one camera.
            
            self.cameraButton.isEnabled = self.videoDeviceDiscoverySession.uniqueDevicePositionsCount() > 1
            self.cameraButton.isHidden = false
            //self.cameraButton.isHidden = !(self.videoDeviceDiscoverySession.uniqueDevicePositionsCount() > 1)
            self.tabBarController?.tabBar.isHidden = false
            self.recordButton.imageView?.image = UIImage(named: "RecordCameraButton")
            //self.recordButton.setTitle(NSLocalizedString("Record", comment: "Recording button record title"), for: [])
            
            // Only enable the ability to record after 1 second
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.recordButton.isEnabled = true
            }
        }
    }
    
    // MARK: KVO and Notifications
    
    private var sessionRunningObserveContext = 0
    
    private func addObservers() {
        session.addObserver(self, forKeyPath: "running", options: .new, context: &sessionRunningObserveContext)
        
        NotificationCenter.default.addObserver(self, selector: #selector(subjectAreaDidChange), name: Notification.Name("AVCaptureDeviceSubjectAreaDidChangeNotification"), object: videoDeviceInput.device)
        NotificationCenter.default.addObserver(self, selector: #selector(sessionRuntimeError), name: Notification.Name("AVCaptureSessionRuntimeErrorNotification"), object: session)
        
        /*
         A session can only run when the app is full screen. It will be interrupted
         in a multi-app layout, introduced in iOS 9, see also the documentation of
         AVCaptureSessionInterruptionReason. Add observers to handle these session
         interruptions and show a preview is paused message. See the documentation
         of AVCaptureSessionWasInterruptedNotification for other interruption reasons.
         */
        
        NotificationCenter.default.addObserver(self, selector: #selector(sessionWasInterrupted), name: Notification.Name("AVCaptureSessionWasInterruptedNotification"), object: session)
        NotificationCenter.default.addObserver(self, selector: #selector(sessionInterruptionEnded), name: Notification.Name("AVCaptureSessionInterruptionEndedNotification"), object: session)
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self)
        
        session.removeObserver(self, forKeyPath: "running", context: &sessionRunningObserveContext)
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &sessionRunningObserveContext {
            let newValue = change?[.newKey] as AnyObject?
            guard let isSessionRunning = newValue?.boolValue else { return }
            
            DispatchQueue.main.async { [unowned self] in
                
                // Only enable the ability to change camera if the device has more than one camera.
                
                self.cameraButton.isEnabled = isSessionRunning && self.videoDeviceDiscoverySession.uniqueDevicePositionsCount() > 1
                self.recordButton.isEnabled = isSessionRunning && self.movieFileOutput != nil
            }
        }
        else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    func subjectAreaDidChange(notification: NSNotification) {
        let devicePoint = CGPoint(x: 0.5, y: 0.5)
        focus(with: .autoFocus, exposureMode: .continuousAutoExposure, at: devicePoint, monitorSubjectAreaChange: false)
    }
    
    func sessionRuntimeError(notification: NSNotification) {
        guard let errorValue = notification.userInfo?[AVCaptureSessionErrorKey] as? NSError else {
            return
        }
        
        let error = AVError(_nsError: errorValue)
        print("Capture session runtime error: \(error)")
        
        /*
         Automatically try to restart the session running if media services were
         reset and the last start running succeeded. Otherwise, enable the user
         to try to resume the session running.
         */
        
        if error.code == .mediaServicesWereReset {
            sessionQueue.async { [unowned self] in
                if self.isSessionRunning {
                    self.session.startRunning()
                    self.isSessionRunning = self.session.isRunning
                }
                else {
                    DispatchQueue.main.async { [unowned self] in
                        self.resumeButton.isHidden = false
                    }
                }
            }
        }
        else {
            resumeButton.isHidden = false
        }
    }
    
    func sessionWasInterrupted(notification: NSNotification) {
        
        /*
         In some scenarios we want to enable the user to resume the session running.
         For example, if music playback is initiated via control center while
         using AVCam, then the user can let AVCam resume
         the session running, which will stop music playback. Note that stopping
         music playback in control center will not automatically resume the session
         running. Also note that it is not always possible to resume, see `resumeInterruptedSession(_:)`.
         */
        
        if let userInfoValue = notification.userInfo?[AVCaptureSessionInterruptionReasonKey] as AnyObject?, let reasonIntegerValue = userInfoValue.integerValue, let reason = AVCaptureSessionInterruptionReason(rawValue: reasonIntegerValue) {
            print("Capture session was interrupted with the reason \(reason)")
            
            var showResumeButton = false
            
            if reason == AVCaptureSessionInterruptionReason.audioDeviceInUseByAnotherClient || reason == AVCaptureSessionInterruptionReason.videoDeviceInUseByAnotherClient {
                showResumeButton = true
            }
            else if reason == AVCaptureSessionInterruptionReason.videoDeviceNotAvailableWithMultipleForegroundApps {
                
                // Simply fade-in a label to inform the user that the camera is unavailable.
                
                cameraUnavailableLabel.alpha = 0
                cameraUnavailableLabel.isHidden = false
                UIView.animate(withDuration: 0.25) { [unowned self] in
                    self.cameraUnavailableLabel.alpha = 1
                }
            }
            
            if showResumeButton {
                
                // Simply fade-in a button to enable the user to try to resume the session running.
                
                resumeButton.alpha = 0
                resumeButton.isHidden = false
                UIView.animate(withDuration: 0.25) { [unowned self] in
                    self.resumeButton.alpha = 1
                }
            }
        }
    }
    
    func sessionInterruptionEnded(notification: NSNotification) {
        print("Capture session interruption ended")
        
        if !resumeButton.isHidden {
            UIView.animate(withDuration: 0.25,
                           animations: { [unowned self] in
                            self.resumeButton.alpha = 0
                }, completion: { [unowned self] finished in
                    self.resumeButton.isHidden = true
                }
            )
        }
        if !cameraUnavailableLabel.isHidden {
            UIView.animate(withDuration: 0.25,
                           animations: { [unowned self] in
                            self.cameraUnavailableLabel.alpha = 0
                }, completion: { [unowned self] finished in
                    self.cameraUnavailableLabel.isHidden = true
                }
            )
        }
    }
}

extension UIDeviceOrientation {
    var videoOrientation: AVCaptureVideoOrientation? {
        switch self {
        case .portrait: return .portrait
        case .portraitUpsideDown: return .portraitUpsideDown
        case .landscapeLeft: return .landscapeRight
        case .landscapeRight: return .landscapeLeft
        default: return nil
        }
    }
}

extension UIInterfaceOrientation {
    
    var videoOrientation: AVCaptureVideoOrientation? {
        switch self {
        case .portrait: return .portrait
        case .portraitUpsideDown: return .portraitUpsideDown
        case .landscapeLeft: return .landscapeLeft
        case .landscapeRight: return .landscapeRight
        default: return nil
        }
    }
    
}

extension AVCaptureDeviceDiscoverySession {
    
    func uniqueDevicePositionsCount() -> Int {
        var uniqueDevicePositions = [AVCaptureDevicePosition]()
        
        for device in devices {
            if !uniqueDevicePositions.contains(device.position) {
                uniqueDevicePositions.append(device.position)
            }
        }
        
        return uniqueDevicePositions.count
    }
    
}

extension SFSpeechRecognitionTaskDelegate {
    
    func speechRecognitionTask(_ task: SFSpeechRecognitionTask, didFinishSuccessfully successfully: Bool) {
        if successfully {
            print("+++++++++TRUE+++++++++")
        } else {
            print("---------FALSE---------")
        }
    }
    
    func speechRecognitionTask(_ task: SFSpeechRecognitionTask, didFinishRecognition recognitionResult: SFSpeechRecognitionResult) {
        //        console.text = console.text + "\n" + recognitionResult.bestTranscription.formattedString
        print("!!!SpeechRecognitionTask: \(recognitionResult.bestTranscription.formattedString)")
    }
    
}
